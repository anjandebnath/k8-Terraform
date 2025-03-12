const express = require('express');
const AWS = require('aws-sdk');

const app = express();
const PORT = process.env.PORT;

// Configure AWS SDKcd
const s3 = new AWS.S3({
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: process.env.AWS_REGION
});

// GET method to stream the video from S3
app.get('/video', async (req, res) => {
    try {
        const bucketName = process.env.S3_BUCKET_NAME;
        const fileName = process.env.S3_FILE_NAME;

        // Get the file metadata to retrieve its size
        const headParams = {
            Bucket: bucketName,
            Key: fileName
        };
        const headData = await s3.headObject(headParams).promise();
        const fileSize = headData.ContentLength;

        console.log("fileSize", fileSize);
        console.log("headData", headData);

        // Get the requested range from the header
        const range = req.headers.range;
        if (!range) {
            console.log("No Range header, sending full video...");
            const streamParams = { Bucket: bucketName, Key: fileName };

            // Get full video stream from S3
            const videoStream = s3.getObject(streamParams).createReadStream();

            res.writeHead(200, {
                'Content-Length': fileSize,
                'Content-Type': 'video/mp4'
            });

            return videoStream.pipe(res);
        }

        // Parse range header
        const CHUNK_SIZE = 10 ** 6; // 1MB chunks
        const start = Number(range.replace(/\D/g, ""));
        const end = Math.min(start + CHUNK_SIZE, fileSize - 1);

        const contentLength = end - start + 1;
        const streamParams = {
            Bucket: bucketName,
            Key: fileName,
            Range: `bytes=${start}-${end}`
        };

        // Stream the video from S3
        const videoStream = s3.getObject(streamParams).createReadStream();

        res.writeHead(206, {
            'Content-Range': `bytes ${start}-${end}/${fileSize}`,
            'Accept-Ranges': 'bytes',
            'Content-Length': contentLength,
            'Content-Type': 'video/mp4'
        });

        videoStream.pipe(res);
    } catch (error) {
        console.error('Error fetching video:', error);
        res.status(500).json({ error: 'Error fetching video' });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
const express = require('express');
const AWS = require('aws-sdk');

const app = express();


// Configure AWS SDK
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

        // Get the requested range from the header
        const range = req.headers.range;
        if (!range) {
            return res.status(416).send('Requires Range header');
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

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
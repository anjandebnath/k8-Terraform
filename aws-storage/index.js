const express = require("express");
const AWS = require("aws-sdk");

const app = express();

//
// Throws an error if any required environment variables are missing.
//
if (!process.env.PORT) {
    throw new Error("Please specify the port number for the HTTP server with the environment variable PORT.");
}

if (!process.env.S3_BUCKET_NAME) {
    throw new Error("Please specify the name of an AWS S3 bucket in environment variable AWS_S3_BUCKET_NAME.");
}

if (!process.env.AWS_ACCESS_KEY_ID) {
    throw new Error("Please specify the AWS access key ID in environment variable AWS_ACCESS_KEY_ID.");
}

if (!process.env.AWS_SECRET_ACCESS_KEY) {
    throw new Error("Please specify the AWS secret access key in environment variable AWS_SECRET_ACCESS_KEY.");
}

if (!process.env.AWS_REGION) {
    throw new Error("Please specify the AWS region in environment variable AWS_REGION.");
}

//
// Extract environment variables
//
const PORT = process.env.PORT;
const S3_BUCKET_NAME = process.env.S3_BUCKET_NAME;
const AWS_REGION = process.env.AWS_REGION;

console.log(`Serving videos from AWS S3 bucket ${S3_BUCKET_NAME}.`);

//
// Configure AWS SDK
//
AWS.config.update({
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: AWS_REGION
});

const s3 = new AWS.S3();

//
// Registers a HTTP GET route to retrieve videos from S3.
//
app.get("/video", async (req, res) => {
    try {
        const videoKey = req.query.path; // File name in S3
        console.log(`Streaming video from S3: ${videoKey}`);

        // Get the file metadata (size, etc.)
        const headParams = { Bucket: S3_BUCKET_NAME, Key: videoKey };
        const headData = await s3.headObject(headParams).promise();
        const fileSize = headData.ContentLength;

        // Check if Range header is present for partial streaming
        let range = req.headers.range;
        if (!range) {
            console.log("No Range header, sending full video...");
            
            // Get full file stream
            const streamParams = { Bucket: S3_BUCKET_NAME, Key: videoKey };
            const videoStream = s3.getObject(streamParams).createReadStream();

            res.writeHead(200, {
                "Content-Length": fileSize,
                "Content-Type": "video/mp4"
            });

            return videoStream.pipe(res);
        }

        // Parse Range header for partial content streaming
        const CHUNK_SIZE = 10 ** 6; // 1MB chunks
        const start = Number(range.replace(/\D/g, ""));
        const end = Math.min(start + CHUNK_SIZE, fileSize - 1);
        const contentLength = end - start + 1;

        console.log(`Streaming bytes ${start}-${end} of ${fileSize}`);

        const streamParams = {
            Bucket: S3_BUCKET_NAME,
            Key: videoKey,
            Range: `bytes=${start}-${end}`
        };

        // Stream the requested video chunk from S3
        const videoStream = s3.getObject(streamParams).createReadStream();

        res.writeHead(206, {
            "Content-Range": `bytes ${start}-${end}/${fileSize}`,
            "Accept-Ranges": "bytes",
            "Content-Length": contentLength,
            "Content-Type": "video/mp4"
        });

        videoStream.pipe(res);
    } catch (error) {
        console.error('Error fetching video:', error);
        res.status(500).json({ error: 'Error fetching video' });
    }
});

//
// Starts the HTTP server.
//
app.listen(PORT, () => {
    console.log(`Video-Storage service listening on port ${PORT}, point your browser at http://localhost:${PORT}/video`);
});

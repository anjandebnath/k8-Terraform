const express = require("express");
const fs = require('fs');


const app = express();

// Throws an error if the PORT environment variable is missing.
if (!process.env.PORT) {
    throw new Error("Please specify the port number for the HTTP server with the environment variable PORT.");
}

// Extracts the PORT environment variable.
const PORT = process.env.PORT;


// Registers a HTTP GET route for video streaming.
app.get("/video", async (req, res) => {

    const videoPath = "./videos/SampleVideo_1280x720_1mb.mp4";
    console.log("Looking for file at:", videoPath);

    const stats = await fs.promises.stat(videoPath);

    res.writeHead(200, {
        "Content-Length": stats.size,
        "Content-Type": "video/mp4",
    });
    fs.createReadStream(videoPath).pipe(res);
});

// Starts the HTTP server.
// locally run with nodemon : npm run start:dev
app.listen(PORT, () => {
    console.log(`Video-Streaming service listening on port ${PORT}, point your browser at http://localhost:${PORT}/video`);
});
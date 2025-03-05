const express = require("express");
const fs = require('fs');


//
// Throws an error if the PORT environment variable is missing.
//
if (!process.env.PORT) {
    throw new Error("Please specify the port number for the HTTP server with the environment variable PORT.");
}

//
// Extracts the PORT environment variable.
//
const PORT = process.env.PORT;

const app = express();
//const port = 3000;

app.get("/", (req, res) => {
    res.send("Hello World!");
});

//
// Registers a HTTP GET route for video streaming.
app.get("/video", async (req, res) => {

    const path = require('path');

    const videoPath = path.join(__dirname, "videos", "SampleVideo_1280x720_1mb.mp4");
    console.log("Looking for file at:", videoPath);

    const stats = await fs.promises.stat(videoPath);

    res.writeHead(200, {
        "Content-Length": stats.size,
        "Content-Type": "video/mp4",
    });
    fs.createReadStream(videoPath).pipe(res);
});


//
// Starts the HTTP server.
//
app.listen(PORT, () => {
    console.log(`Microservice listening on port ${PORT}, point your browser at http://localhost:${PORT}/video`);
});
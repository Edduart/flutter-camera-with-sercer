const express = require("express");
const multer = require("multer");

const app = express();

// Configure multer for image uploads (adjust options as needed)
const upload = multer({ dest: "uploads/" }); // Uploads will be saved in 'uploads' folder

// Define endpoint for image upload (replace with your desired path)
app.post("/upload", upload.single("image"), (req, res) => {
  console.log("request received!")
  // Access the uploaded image file through req.file
  const image = req.file;

  if (!image) {
    return res.status(400).json({ message: "No image uploaded!" });
  }

  // Implement logic to save the image (e.g., using fs module)
  const fs = require("fs");
  const filePath = `uploads/${image.filename}.jpg`;

  fs.rename(image.path, filePath, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Error saving image!" });
    }

    // Send response to the Flutter app
    console.log("Image upload successfully!")
    res.json({ message: "Image uploaded successfully!" });
  });
});

app.listen(3000, () => console.log("Server listening on port 3000"));

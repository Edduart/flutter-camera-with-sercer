import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart';

Future<String> sendPhotoToServer(String imagePath) async {
    var request = MultipartRequest('POST', Uri.parse('http://192.168.0.33:3000/upload'));
    var imageFile = await MultipartFile.fromPath('image', imagePath); // Await the future
    request.files.add(imageFile);
    var response = await request.send();

    // Handle the server response (success or error)
    if (response.statusCode == 200) {
        return 'Image uploaded successfully!';
    } else {
        return 'Error uploading image: ${response.statusCode}';
    }
}

class PreviewPage extends StatelessWidget {
  final XFile picture;

  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
            const SizedBox(height: 24),
            Text(picture.name),
            ElevatedButton(
              onPressed: () async {
                // Send photo to server and handle response (optional)
                final response = await sendPhotoToServer(picture.path);
                if (true) {
                  // Show success or error message based on response
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response),
                    ),
                  );
                }
              },
              child: const Text("Upload Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
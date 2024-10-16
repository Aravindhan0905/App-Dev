import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class FacultyHomePage extends StatelessWidget {
  const FacultyHomePage({super.key});

  // Function to upload CSV file
  Future<void> uploadFile() async {
    try {
      // Allowing the user to pick a CSV file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'], // Only CSV files allowed
      );

      if (result != null) {
        // Get the file from the selected path
        File file = File(result.files.single.path!);

        // Sending the file to the backend
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://10.0.2.2:5000/upload-students'), // Change URL if necessary
        );

        // Attach the file to the request
        request.files.add(
          await http.MultipartFile.fromPath('file', file.path),
        );

        // Sending the request
        var response = await request.send();

        // Handle response from the server
        if (response.statusCode == 200) {
          print('Upload successful!');
        } else {
          print('Upload failed with status: ${response.statusCode}');
        }
      } else {
        // If no file is selected
        print('No file selected');
      }
    } catch (e) {
      // Error handling
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty Home')),
      body: Center(
        child: ElevatedButton(
          onPressed:
              uploadFile, // Call the uploadFile method when button is pressed
          child: const Text('Upload Students CSV'),
        ),
      ),
    );
  }
}

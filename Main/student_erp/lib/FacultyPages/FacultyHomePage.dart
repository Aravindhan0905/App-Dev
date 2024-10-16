import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class FacultyHomePage extends StatelessWidget {
  const FacultyHomePage({super.key});

  Future<void> uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://10.0.2.2:5000/upload-students'),
        );

        request.files.add(
          await http.MultipartFile.fromPath('file', file.path),
        );

        var response = await request.send();
        if (response.statusCode == 200) {
          print('Upload successful!');
        } else {
          print('Upload failed with status: ${response.statusCode}');
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadFile,
          child: const Text('Upload Students CSV'),
        ),
      ),
    );
  }
}

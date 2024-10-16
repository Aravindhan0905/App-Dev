import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:student_erp/StudentPages/LoginPage.dart';
import 'package:student_erp/StudentPages/AttendancePage.dart';
import 'package:student_erp/StudentPages/FeesPage.dart';
import 'package:student_erp/StudentPages/NotesPage.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});

  @override
  _FacultyHomePageState createState() => _FacultyHomePageState();
}

class _FacultyHomePageState extends State<FacultyHomePage> {
  final int _selectedIndex = 0;

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
          Uri.parse('http://10.0.2.2:5000/upload-students'), // Change URL if necessary
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

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        // Staying on HomePage, no action needed
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Home'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Opens the sliding drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Faculty Name"), // Replace with actual faculty name
              accountEmail: Text("faculty.email@example.com"), // Replace with actual email
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/sakthivel.jpg"), // Replace with actual image
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // The background color of the drawer header
              ),
            ),
            const ListTile(
              title: Text("Personal Details", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const ListTile(
              title: Text("Email ID: faculty.email@example.com"), // Replace with actual email
            ),
            const Divider(),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () {
                // Handle logout logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()), // Redirects to the LoginPage
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadFile, // Call the uploadFile method when button is pressed
          child: const Text('Upload Students CSV'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Fees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}

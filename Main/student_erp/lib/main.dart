import 'package:flutter/material.dart';
import 'Pages/login_page.dart';

void main() {
  runApp(StudentERPApp());
}

class StudentERPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ERP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set the initial page to the Login Page
    );
  }
}

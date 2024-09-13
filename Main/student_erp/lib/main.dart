import 'package:flutter/material.dart';
import 'StudentPages/LoginPage.dart';

void main() {
  runApp(const StudentERPApp());
}

class StudentERPApp extends StatelessWidget {
  const StudentERPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student ERP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(), // Set the initial page to the Login Page
    );
  }
}

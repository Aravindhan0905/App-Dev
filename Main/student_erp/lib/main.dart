import 'package:flutter/material.dart';
import 'StudentPages/LoginPage.dart';

void main() {
  runApp(StudentERPApp());
}

class StudentERPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student ERP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FacultyHomePage extends StatelessWidget {
  const FacultyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Home Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Faculty Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

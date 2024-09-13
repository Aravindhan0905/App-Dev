import 'package:flutter/material.dart';

class HodHomePage extends StatelessWidget {
  const HodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HoD Home'),
      ),
      body: const Center(
        child: Text('Welcome to HoD Dashboard!'),
      ),
    );
  }
}

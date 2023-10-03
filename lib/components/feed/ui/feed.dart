import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() {
    return _Feed();
  }
}

class _Feed extends State<Feed> {
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("Feed"),
        ),
      ),
    );
  }
}
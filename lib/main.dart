import 'package:flutter/material.dart';
import 'package:guarap/ui/publish_photo.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 0, 0, 0)); // Define the color palette for the app

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme
    ),
    home: const PublishPhoto()),);
}

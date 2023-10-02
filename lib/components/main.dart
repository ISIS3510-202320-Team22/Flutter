import 'package:flutter/material.dart';
import 'package:guarap/components/home/ui/home.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        0, 0, 0, 0)); // Define the color palette for the app

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      home: const Home() // Aca cambiar la clase que quieres testear
    ),
  );
}

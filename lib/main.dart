import 'package:flutter/material.dart';
import 'package:guarap/ui/home/home.dart';
import 'package:guarap/ui/publish_photos/publish_photo.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        0, 0, 0, 0)); // Define the color palette for the app

void main() {
  runApp(
    MaterialApp(
      theme:
          ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Guarap",
            style: GoogleFonts.pattaya(color: Colors.black, fontSize: 40),
          ),
          centerTitle: true,
        ),
        body: const Home(), // Aca poner la vista que quieren ir testeando
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: GoogleFonts.arima(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Settings"),
        ));
  }
}

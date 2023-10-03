import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.arima(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
      ),
      body: Center(
        child: Text("Profile"),
      )
    );
  }
}
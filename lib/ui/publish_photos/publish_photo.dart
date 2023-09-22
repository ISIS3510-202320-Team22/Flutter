import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/ui/header.dart';

class PublishPhoto extends StatelessWidget {
  const PublishPhoto({super.key});

  @override
  Widget build(context) {
    return Header(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "New Post",
            style: GoogleFonts.roboto(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

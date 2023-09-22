import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PublishPhoto extends StatelessWidget {
  const PublishPhoto({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Guarap", 
              style: GoogleFonts.pattaya(color: Colors.black,fontSize: 40),
              ),
              centerTitle: true,),
      body: const Text("Holanda"),
    );
  }
}

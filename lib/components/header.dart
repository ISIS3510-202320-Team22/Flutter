import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Header extends StatelessWidget {

  const Header(this.body,{super.key});

  final Widget body;
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Guarap",
            style: GoogleFonts.pattaya(color: Colors.black, fontSize: 40),
          ),
          centerTitle: true,
        ),
      body: body,
    );
  }
}
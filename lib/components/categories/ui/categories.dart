import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Comenatrio prueba

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() {
    return _Categories();
  }
}

class _Categories extends State<Categories> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Categories",
            style: GoogleFonts.arima(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
      ),
      body: Center(
        child: Text("Categories"),
      )
    );
  }
}
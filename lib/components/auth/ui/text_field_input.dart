import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput(
      {Key? key,
      required this.controller,
      this.isPassword = false,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintStyle: GoogleFonts.roboto(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}

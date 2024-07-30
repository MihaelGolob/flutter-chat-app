import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  const InputField({super.key, required this.controller, required this.hintText, this.prefixIcon, this.suffixIcon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.quicksand(color: Colors.white),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(color: Colors.grey[400]),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        suffixIcon: Icon(suffixIcon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromRGBO(1, 189, 173, 1)),
        ),
      ),
    );
  }
}

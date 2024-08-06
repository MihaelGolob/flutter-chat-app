import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.quicksand(color: Colors.white),
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.quicksand(color: Colors.grey[400]),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.remove_red_eye_outlined : Icons.emergency, color: Colors.white), onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        }),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color.fromRGBO(1, 189, 173, 1)),
        ),
      ),
    );
  }
}

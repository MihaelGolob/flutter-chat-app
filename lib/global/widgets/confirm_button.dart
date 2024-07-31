import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const ConfirmButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 124, 124),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(text, style: GoogleFonts.quicksand(fontSize: 20, color: Colors.white))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPreview extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String lastMessageTime;
  const ContactPreview({super.key, required this.name, required this.lastMessage, required this.lastMessageTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: GoogleFonts.quicksand(fontSize: 22),
          ),
          Row(
            children: [
              Text(lastMessage, style: GoogleFonts.quicksand(color: Colors.grey[700])),
              const Spacer(),
              Text(lastMessageTime, style: GoogleFonts.quicksand(color: Colors.grey[700])),
            ],
          )
        ],
      ),
    );
  }
}

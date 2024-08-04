import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final DateTime time;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.time, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  textAlign: isSender ? TextAlign.right : TextAlign.left,
                  style: GoogleFonts.quicksand(color: isSender ? Colors.white : Colors.black),
                ),
                Text(
                  textAlign: isSender ? TextAlign.right : TextAlign.left,
                  _formatDateTime(time),
                  style: GoogleFonts.quicksand(color: isSender ? Colors.grey[200] : Colors.grey[700], fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

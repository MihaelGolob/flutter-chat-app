import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPreview extends StatelessWidget {
  final User user;
  final VoidCallback goToChat;
  const ContactPreview({super.key, required this.user, required this.goToChat});

  String lastMessage() {
    // todo
    return 'Thank you this is approved!';
  }

  String lastMessageTime() {
    // todo
    return '12:00';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToChat,
      child: Container(
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
              user.username,
              style: GoogleFonts.quicksand(fontSize: 22),
            ),
            Row(
              children: [
                Text(lastMessage(), style: GoogleFonts.quicksand(color: Colors.grey[700])),
                const Spacer(),
                Text(lastMessageTime(), style: GoogleFonts.quicksand(color: Colors.grey[700])),
              ],
            )
          ],
        ),
      ),
    );
  }
}

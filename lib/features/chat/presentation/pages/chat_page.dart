import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageData {
  final User user;
  const ChatPageData({required this.user});
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatPageData;
    final user = args.user;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 33, 124, 124), Color.fromARGB(255, 28, 54, 78)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(user.username, style: GoogleFonts.quicksand(color: Colors.white)),
          backgroundColor: Colors.transparent,
          titleSpacing: 20,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

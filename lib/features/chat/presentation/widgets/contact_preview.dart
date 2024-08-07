import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:chat_app/global/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPreview extends StatefulWidget {
  final User user;
  final VoidCallback goToChat;
  const ContactPreview({super.key, required this.user, required this.goToChat});

  @override
  State<ContactPreview> createState() => _ContactPreviewState();
}

class _ContactPreviewState extends State<ContactPreview> {
  late final Future<Message> lastMessage;

  String _formatDateTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void initState() {
    super.initState();
    lastMessage = context.read<ChatCubit>().getLastMessageForUser(widget.user);
    Log.i('Init state for ${widget.user.username}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.goToChat,
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
              widget.user.username,
              style: GoogleFonts.quicksand(fontSize: 22),
            ),
            FutureBuilder(
              future: lastMessage,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();

                return Row(
                  children: [
                    Text(snapshot.data!.message, style: GoogleFonts.quicksand(color: Colors.grey[700])),
                    const Spacer(),
                    Text(_formatDateTime(snapshot.data!.timestamp), style: GoogleFonts.quicksand(color: Colors.grey[700])),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

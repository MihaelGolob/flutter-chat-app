import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageData {
  final User receiver;
  const ChatPageData({required this.receiver});
}

class ChatPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatPageData;
    final receiver = args.receiver;

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
          title: Text(receiver.username, style: GoogleFonts.quicksand(color: Colors.white)),
          backgroundColor: Colors.transparent,
          titleSpacing: 20,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: _buildChats(receiver),
              ),
              SizedBox(
                height: 80,
                child: InputField(
                  controller: _controller,
                  hintText: 'Aa...',
                  prefixIcon: Icons.arrow_upward,
                  onPrefixIconTap: () {
                    context.read<ChatCubit>().sendMessage(receiver, _controller.text);
                    _controller.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildChats(User receiver) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) => StreamBuilder(
        stream: context.read<ChatCubit>().getAllMessagesForUser(receiver),
        builder: (context, snapshot) {
          if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final messages = snapshot.data as List<Message>;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Text(messages[index].message);
            },
          );
        },
      ),
    );
  }
}

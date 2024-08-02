import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/features/chat/presentation/widgets/contact_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 33, 124, 124), Color.fromARGB(255, 28, 54, 78)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthInitial || state is AuthError) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      }, builder: (context, state) {
        if (state is! AuthSuccess) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              state.user.email,
              style: GoogleFonts.quicksand(color: Colors.white),
            ),
            titleSpacing: 20,
            actions: [
              IconButton(
                onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
                icon: const Icon(Icons.logout_outlined, color: Colors.white),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Write to your colleagues',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 80,
                          child: InputField(
                            controller: TextEditingController(),
                            hintText: 'Search',
                            prefixIcon: Icons.search_outlined,
                            suffixIcon: Icons.arrow_right_alt_rounded,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ContactPreview(name: 'Ann Smith', lastMessage: 'Thank you, this is approved', lastMessageTime: '13:42',),
                      ContactPreview(name: 'Ann Smith', lastMessage: 'Thank you, this is approved', lastMessageTime: '13:42',),
                      ContactPreview(name: 'Ann Smith', lastMessage: 'Thank you, this is approved', lastMessageTime: '13:42',),
                      ContactPreview(name: 'Ann Smith', lastMessage: 'Thank you, this is approved', lastMessageTime: '13:42',),
                      ContactPreview(name: 'Ann Smith', lastMessage: 'Thank you, this is approved', lastMessageTime: '13:42',),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

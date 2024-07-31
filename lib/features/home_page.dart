import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WELCOME!!!', style: GoogleFonts.quicksand(fontSize: 30)),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is AuthInitial) {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
              child: GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(AuthLogout());
                },
                child: Text('Click here to logout', style: GoogleFonts.quicksand(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

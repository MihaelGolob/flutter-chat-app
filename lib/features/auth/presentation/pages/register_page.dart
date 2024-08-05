import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/global/widgets/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final VoidCallback switchToLogin;
  RegisterPage({super.key, required this.switchToLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 33, 124, 124), Color.fromARGB(255, 28, 54, 78)],
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.of(context).pushReplacementNamed('/');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? '')));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _displayRegisterPage(context);
              }
            },
          ),
        ),
      ),
    );
  }

  _displayRegisterPage(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/chat.png',
                color: Colors.white,
                width: 100,
              ),
              const SizedBox(height: 20),
              Text('Welcome!', style: GoogleFonts.quicksand(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Let\'s create you an account', style: GoogleFonts.quicksand(fontSize: 16, color: Colors.grey[400])),
              const SizedBox(height: 20),
              InputField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),
              InputField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.remove_red_eye_outlined,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              InputField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.remove_red_eye_outlined,
                obscureText: true,
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 25),
              ConfirmButton(
                text: 'REGISTER',
                onTap: () => context.read<AuthBloc>().add(
                      AuthRegister(
                        email: _emailController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ),
                    ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              GestureDetector(
                onTap: switchToLogin,
                child: Text('Already have an account? Login here', style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey[400])),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chat_app/features/auth/presentation/widgets/company_button.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/global/widgets/confirm_button.dart';
import 'package:flutter/material.dart';
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
          child: SingleChildScrollView(
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
                    ConfirmButton(text: 'REGISTER', onTap: () {}),
                    const SizedBox(height: 20),
                    const Spacer(),
                    GestureDetector(
                      onTap: switchToLogin,
                      child: Text('Already have an account? Login here', style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey[400])),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

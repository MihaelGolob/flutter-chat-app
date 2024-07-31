import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/company_button.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/global/widgets/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final VoidCallback switchToRegister;
  LoginPage({super.key, required this.switchToRegister});

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
              if (state is AuthSuccess) {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            },
            builder: (blocContext, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _displayLoginPage(context);
              }
            },
          ),
        ),
      ),
    );
  }

  _displayLoginPage(BuildContext context) {
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
              Text('Hello again!', style: GoogleFonts.quicksand(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Welcome back to the chat app', style: GoogleFonts.quicksand(fontSize: 16, color: Colors.grey[400])),
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?', style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey[400]), textAlign: TextAlign.end),
                ],
              ),
              const SizedBox(height: 25),
              ConfirmButton(
                text: 'LOGIN',
                onTap: () => context.read<AuthBloc>().add(AuthLogin(email: _emailController.text, password: _passwordController.text)),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // line
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // or
                  Text('or', style: GoogleFonts.quicksand(fontSize: 15, color: Colors.white)),
                  const SizedBox(width: 10),
                  // line
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CompanyButton(image: Image.asset('assets/images/google.png'), onPressed: () {}),
                  CompanyButton(image: Image.asset('assets/images/apple.png'), onPressed: () {}),
                  CompanyButton(image: Image.asset('assets/images/facebook.png'), onPressed: () {}),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: switchToRegister,
                child: Text('Don\'t have an account? Sign Up', style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey[400])),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

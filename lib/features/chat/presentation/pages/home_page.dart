import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/presentation/widgets/input_field.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/chat/presentation/widgets/contact_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _allUsersFuture;

  @override
  void initState() {
    super.initState();
    _allUsersFuture = context.read<ChatCubit>().getAllUsers();
  }

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
                _buildHeader(),
                _buildContactList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              key: const ValueKey('home_title'),
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
    );
  }

  _buildContactList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) => FutureBuilder(
            future: _allUsersFuture,
            builder: (context, snapshot) {
              if (state is ChatLoading || !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatError) {
                return Center(child: Text(state.message, textAlign: TextAlign.center));
              }

              final contacts = snapshot.data as List<User>;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => ContactPreview(
                  user: contacts[index],
                  goToChat: () {
                    final data = ChatPageData(receiver: contacts[index]);
                    Navigator.pushNamed(context, '/chat', arguments: data);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

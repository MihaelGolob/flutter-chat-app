import 'package:chat_app/features/auth/presentation/pages/login_or_register_page.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/chat/presentation/pages/home_page.dart';

final chatRoutes = {
  '/': (context) => const LoginOrRegisterPage(),
  '/home': (context) => const HomePage(),
  '/chat': (context) => ChatPage(),
};

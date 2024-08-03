import 'package:chat_app/app_bloc_observer.dart';
import 'package:chat_app/chat_routes.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:chat_app/features/auth/data/auth_repository_firebase.dart';
import 'package:chat_app/features/auth/data/user_repository.dart';
import 'package:chat_app/features/auth/data/user_repository_firebase.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/data/chat_repository_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepositoryFirebase()),
        RepositoryProvider<ChatRepository>(create: (context) => ChatRepositoryFirebase()),
        RepositoryProvider<UserRepository>(create: (context) => UserRepositoryFirebase()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(context.read<AuthRepository>(), context.read<UserRepository>())),
          BlocProvider<ChatCubit>(create: (context) => ChatCubit(context.read<ChatRepository>(), context.read<UserRepository>())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
            ),
          ),
          routes: chatRoutes,
        ),
      ),
    );
  }
}

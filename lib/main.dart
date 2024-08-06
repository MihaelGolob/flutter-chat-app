import 'package:chat_app/global/app_bloc_observer.dart';
import 'package:chat_app/global/chat_routes.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  makeGestureBarBackgroundTransparent();

  // Repositories
  final AuthRepository authRepository = AuthRepositoryFirebase();
  final ChatRepository chatRepository = ChatRepositoryFirebase();
  final UserRepository userRepository = UserRepositoryFirebase();

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
    userRepository: userRepository,
  ));
}

void makeGestureBarBackgroundTransparent() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  final UserRepository userRepository;
  const MyApp({super.key, required this.authRepository, required this.chatRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => authRepository),
        RepositoryProvider<ChatRepository>(create: (context) => chatRepository),
        RepositoryProvider<UserRepository>(create: (context) => userRepository),
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

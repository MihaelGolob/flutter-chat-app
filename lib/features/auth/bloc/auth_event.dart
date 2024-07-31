part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthRegister({required this.email, required this.password, required this.confirmPassword});
}

final class AuthLogout extends AuthEvent {}

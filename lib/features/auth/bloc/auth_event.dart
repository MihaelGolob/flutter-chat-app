part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {}

final class AuthRegister extends AuthEvent {}

final class AuthLogout extends AuthEvent {}

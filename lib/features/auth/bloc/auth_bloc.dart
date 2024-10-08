import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:chat_app/features/auth/data/user_repository.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthBloc(this._authRepository, this._userRepository) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) => _onAuthLogin(event, emit));
    on<AuthRegister>((event, emit) => _onAuthRegister(event, emit));
    on<AuthLogout>((event, emit) => _onAuthLogout(event, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final userId = await _authRepository.signInWithEmailAndPassword(event.email, event.password);
      final newUser = User(id: userId, username: event.email, email: event.email);
      _userRepository.setUser(newUser);
      _userRepository.saveUser(newUser);
      emit(AuthSuccess(_userRepository.getUser()!));
    } catch (e) {
      emit(AuthError(message: 'Failed to sign in'));
    }
  }

  void _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    if (event.password != event.confirmPassword) {
      emit(AuthError(message: 'Passwords do not match'));
      return;
    }

    try {
      emit(AuthLoading());
      await _authRepository.registerWithEmailAndPassword(event.email, event.password);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign up'));
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      _userRepository.clearUser();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign out'));
    }
  }

  String getCurrentUserId() {
    final user = _userRepository.getUser();
    if (user == null) throw Exception('User not set');
    return user.id;
  }
}

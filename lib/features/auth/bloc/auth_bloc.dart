import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) => _onAuthLogin(event, emit));
    on<AuthRegister>((event, emit) => _onAuthRegister(event, emit));
    on<AuthLogout>((event, emit) => _onAuthLogout(event, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await _authRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(AuthSuccess(User(id: '0', username: event.email, email: event.email)));
    } catch (e) {
      emit(AuthError('Failed to sign in'));
    }
  }

  void _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    if (event.password != event.confirmPassword) {
      emit(AuthError('Passwords do not match'));
      return;
    }

    try {
      emit(AuthLoading());
      await _authRepository.registerWithEmailAndPassword(event.email, event.password);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Failed to sign up'));
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Failed to sign out'));
    }
  }
}

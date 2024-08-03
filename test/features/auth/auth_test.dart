import 'package:bloc_test/bloc_test.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:chat_app/features/auth/data/user_repository_firebase.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRepositoryMock extends AuthRepository {
  @override
  Future<void> registerWithEmailAndPassword(String email, String password) {
    // always successfully register
    return Future.value();
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) {
    if (email == 'test@test.com' && password == 'test123') {
      return Future.value('0');
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}

void main() {
  group('Auth tests', () {
    group('Auth bloc tests', () {
      late AuthBloc authBloc;

      setUp(() async {
        authBloc = AuthBloc(AuthRepositoryMock(), UserRepositoryFirebase());
      });

      test('Initial state should be AuthInitial', () {
        expect(authBloc.state, AuthInitial());
      });

      blocTest(
        'Signs in with correct credentials gives AuthSuccess state',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthLogin(email: 'test@test.com', password: 'test123')),
        expect: () => [AuthLoading(), AuthSuccess(const User(id: '0', username: 'test@test.com', email: 'test@test.com'))],
      );

      blocTest(
        'Signs in with incorrect password gives AuthError state',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthLogin(email: 'test@test.com', password: 'test')),
        expect: () => [AuthLoading(), AuthError()],
      );

      blocTest(
        'Signs in with incorrect email gives AuthError state',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthLogin(email: 'test@te.com', password: 'test123')),
        expect: () => [AuthLoading(), AuthError()],
      );

      blocTest(
        'Register with different passwords gives AuthError state',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthRegister(email: 'test@test.com', password: 'test123', confirmPassword: 'test')),
        expect: () => [AuthError()],
      );

      blocTest(
        'Register with same passwords gives AuthInitial state',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthRegister(email: 'test@test.com', password: 'test123', confirmPassword: 'test123')),
        expect: () => [AuthLoading(), AuthInitial()],
      );
    });
  });
}

import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryFirebase implements AuthRepository {
  @override
  Future<void> registerWithEmailAndPassword(String email, String password) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

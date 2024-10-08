import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:chat_app/global/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryFirebase implements AuthRepository {
  @override
  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Log.i(e);
      rethrow;
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return FirebaseAuth.instance.currentUser?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      Log.i(e);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Log.i(e);
      rethrow;
    }
  }
}

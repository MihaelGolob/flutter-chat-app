abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  String getUserId();
}

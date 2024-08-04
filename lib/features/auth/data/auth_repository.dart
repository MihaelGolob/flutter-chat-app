abstract class AuthRepository {
  Future<String> signInWithEmailAndPassword(String email, String password); // return user id
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

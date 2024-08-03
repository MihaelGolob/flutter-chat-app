import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  User? _currentUser;

  final String _kUsersCollection = 'users';

  @override
  User? getUser() {
    return _currentUser;
  }

  @override
  void setUser(User user) {
    _currentUser = user;
  }

  @override
  void clearUser() {
    _currentUser = null;
  }

  @override
  void addUserToServer(User user) {
    try {
      FirebaseFirestore.instance.collection(_kUsersCollection).doc(user.email).set(user.toMap());
    } catch (e) {
      print('Error when adding new user: $e');
    }
  }
}

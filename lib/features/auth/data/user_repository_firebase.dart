import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  User? _currentUser;
  late final FirebaseFirestore _db;
  final String _kUsersCollection = 'users';

  UserRepositoryFirebase() {
    _db = FirebaseFirestore.instance;
  }

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
  void saveUser(User user) {
    try {
      _db.collection(_kUsersCollection).doc(user.email).set(user.toMap());
    } catch (e) {
      print('Error when adding new user: $e');
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      return _db.collection(_kUsersCollection).get().then((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) => User.fromMap(doc.data() as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      print('Error when getting all users: $e');
      return Future.value([]);
    }
  }
}

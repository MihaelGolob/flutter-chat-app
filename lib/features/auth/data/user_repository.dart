import 'package:chat_app/features/auth/models/user_model.dart';

abstract class UserRepository {
  // save user to database to store it
  void saveUser(User user);
  Future<List<User>> getAllUsers();

  void setUser(User user);
  User? getUser();
  void clearUser();
}

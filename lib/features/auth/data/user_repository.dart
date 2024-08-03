import 'package:chat_app/features/auth/models/user_model.dart';

abstract class UserRepository {
  void addUserToServer(User user);
  void setUser(User user);
  User? getUser();
  void clearUser();
}

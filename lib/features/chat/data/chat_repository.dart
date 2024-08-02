import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/models/message_model.dart';

abstract class ChatRepository {
  List<User> getAllUsers();
  List<Message> getAllMessagesForUser(User user);
  Message getLastMessageForUser(User user);
}

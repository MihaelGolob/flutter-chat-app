import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/models/message_model.dart';

abstract class ChatRepository {
  Future<void> addNewUser(User user);
  Future<List<User>> getAllUsers();

  Future<List<Message>> getAllMessagesForUser(User me, User user);
  Future<Message> getLastMessageForUser(User me, User user);

  Future<void> sendMessage(User me, User user, Message message);
}

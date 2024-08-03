import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/models/message_model.dart';

abstract class ChatRepository {
  Future<List<User>> getAllUsers();
  Future<List<Message>> getAllMessagesForUser(User user);
  Future<Message> getLastMessageForUser(User user);

  Future<void> sendMessage(User user, Message message);
}

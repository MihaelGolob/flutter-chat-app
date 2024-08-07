import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:chat_app/global/log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryFirebase extends ChatRepository {
  late final FirebaseFirestore _db;

  final String _kChatCollection = 'chat';
  final String _kMessagesCollection = 'messages';

  ChatRepositoryFirebase() {
    _db = FirebaseFirestore.instance;
  }

  @override
  Stream<List<Message>> getAllMessagesForUser(User me, User user) {
    return _db.collection(_kChatCollection).doc(_getChatId(me, user)).collection(_kMessagesCollection).snapshots().map<List<Message>>((event) {
      List<Message> messages = [];

      for (var doc in event.docs) {
        try {
          messages.add(Message.fromMap(doc.data()));
        } catch (e) {
          Log.w('Error when getting all messages: $e');
        }
      }
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return messages;
    });
  }

  @override
  Future<Message> getLastMessageForUser(User me, User user) {
    try {
      return _db.collection(_kChatCollection).doc(_getChatId(me, user)).collection(_kMessagesCollection).get().then((QuerySnapshot snapshot) {
        // order messages
        final messages = snapshot.docs.map((e) => Message.fromMap(e.data() as Map<String, dynamic>)).toList();
        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return messages.isNotEmpty ? messages.first : Message.empty();
      });
    } catch (e) {
      Log.w('Error when getting last message: $e');
      return Future.value(Message(message: '', senderId: '', timestamp: DateTime.now()));
    }
  }

  @override
  Future<void> sendMessage(User me, User user, Message message) async {
    try {
      await _db
          .collection(_kChatCollection)
          .doc(_getChatId(me, user))
          .collection(_kMessagesCollection)
          .add(message.toMap())
          .then((DocumentReference doc) => Log.i('Message sent ${message.message}'));
    } catch (e) {
      Log.w('Error when sending message: $e');
    }
  }

  String _getChatId(User me, User user) {
    final users = [me.id, user.id]..sort();
    return users.join('_');
  }
}

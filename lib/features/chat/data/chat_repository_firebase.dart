import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryFirebase extends ChatRepository {
  late final FirebaseFirestore _db;

  final String _kChatCollection = 'chat';
  final String _kUsersCollection = 'users';

  ChatRepositoryFirebase() {
    _db = FirebaseFirestore.instance;
  }

  @override
  Future<List<Message>> getAllMessagesForUser(User me, User user) {
    throw UnimplementedError();
  }

  @override
  Future<void> addNewUser(User user) async {
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

  @override
  Future<Message> getLastMessageForUser(User me, User user) {
    try {
      return _db.collection(_kChatCollection).doc(_getChatId(me, user)).collection('messages').get().then((QuerySnapshot snapshot) {
        return Message.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error when getting last message: $e');
      return Future.value(Message(message: '', senderId: '', timestamp: DateTime.now()));
    }
  }

  @override
  Future<void> sendMessage(User me, User user, Message message) async {
    try {
      await _db
          .collection(_kChatCollection)
          .doc(_getChatId(me, user))
          .collection('messages')
          .add(message.toMap())
          .then((DocumentReference doc) => print('Message sent ${message.message}'));
    } catch (e) {
      print('Error when sending message: $e');
    }
  }

  String _getChatId(User me, User user) {
    final users = [me.email, user.email]..sort();
    return users.join('_');
  }
}

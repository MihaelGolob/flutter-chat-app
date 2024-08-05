import 'package:bloc_test/bloc_test.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../auth/auth_bloc_test.dart';

class ChatRepositoryMock extends ChatRepository {
  final Map<String, List<Message>> _messages = {};

  @override
  Stream<List<Message>> getAllMessagesForUser(User me, User user) async* {
    yield _messages[_chatId(me, user)]!;
  }

  @override
  Future<Message> getLastMessageForUser(User me, User user) {
    return Future.value(_messages[_chatId(me, user)]!.last);
  }

  @override
  Future<void> sendMessage(User me, User user, Message message) {
    _messages[_chatId(me, user)]!.add(message);
    return Future.value();
  }

  String _chatId(User me, User user) {
    final users = [me.id, user.id];
    users.sort();
    return users.join('_');
  }
}

void main() {
  group('Chat cubit tests', () {
    late ChatCubit chatCubit;
    User me = const User(id: '0', email: 'me@gmail.com', username: 'me');
    User receiver = const User(id: '1', email: 'receiver@gmail.com', username: 'receiver');

    setUp(() {
      var userRepository = UserRepositoryMock();
      chatCubit = ChatCubit(ChatRepositoryMock(), userRepository);

      // add users to repository
      userRepository.saveUser(me);
      userRepository.saveUser(receiver);

      userRepository.setUser(me);
    });

    blocTest(
      'Send empty message does nothing',
      build: () => chatCubit,
      act: (cubit) => cubit.sendMessage(receiver, ''),
      expect: () => <ChatState>[],
    );

    blocTest('Get all users does not return me',
        build: () => chatCubit,
        act: (cubit) async {
          final users = await cubit.getAllUsers();
          final includesMe = users.any((user) => user.id == me.id);
          expect(includesMe, false);
        });
  });
}

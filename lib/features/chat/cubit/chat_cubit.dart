import 'package:chat_app/features/auth/data/user_repository.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;

  ChatCubit(this._chatRepository, this._userRepository) : super(ChatEmpty());

  Future<List<User>> getAllUsers() async {
    try {
      emit(ChatLoading());
      var users = await _userRepository.getAllUsers();
      emit(ChatEmpty());
      return users;
    } catch (e) {
      emit(ChatError(e.toString()));
      return [];
    }
  }

  Stream<List<Message>> getAllMessagesForUser(User user) {
    final me = _userRepository.getUser();
    if (me == null) throw Exception('User not set');

    try {
      emit(ChatEmpty());
      return _chatRepository.getAllMessagesForUser(me, user);
    } catch (e) {
      emit(ChatError(e.toString()));
      return const Stream.empty();
    }
  }

  Future<Message> getLastMessageForUser(User user) async {
    final me = _userRepository.getUser();
    if (me == null) throw Exception('User not set');

    try {
      emit(ChatLoading());
      var message = await _chatRepository.getLastMessageForUser(me, user);
      emit(ChatEmpty());

      return message;
    } catch (e) {
      emit(ChatError(e.toString()));
      return Message.empty();
    }
  }

  Future<void> sendMessage(User user, String message) async {
    final me = _userRepository.getUser();
    if (me == null) throw Exception('User not set');
    if (message.isEmpty) return;

    try {
      emit(ChatLoading());
      final messageType = Message(message: message, senderId: me.id, timestamp: DateTime.now());
      await _chatRepository.sendMessage(me, user, messageType);
      emit(ChatEmpty());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}

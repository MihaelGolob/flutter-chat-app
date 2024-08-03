import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/data/chat_repository.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  late User? _me;

  ChatCubit(this._chatRepository) : super(ChatEmpty());

  void setCurrentUser(User user) {
    _me = user;
  }

  Future<List<User>> getAllUsers() async {
    emit(ChatLoading());
    var users = await _chatRepository.getAllUsers();
    emit(ChatEmpty());

    return users;
  }

  Future<List<Message>> getAllMessagesForUser(User user) async {
    if (_me == null) throw Exception('User not set');

    emit(ChatLoading());
    var messages = await _chatRepository.getAllMessagesForUser(_me!, user);
    emit(ChatEmpty());

    return messages;
  }

  Future<Message> getLastMessageForUser(User user) async {
    if (_me == null) throw Exception('User not set');

    emit(ChatLoading());
    var message = await _chatRepository.getLastMessageForUser(_me!, user);
    emit(ChatEmpty());

    return message;
  }

  Future<void> sendMessage(User user, Message message) async {
    if (_me == null) throw Exception('User not set');

    emit(ChatLoading());
    await _chatRepository.sendMessage(_me!, user, message);
    emit(ChatEmpty());
  }
}

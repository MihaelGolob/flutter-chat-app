part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatEmpty extends ChatState {}

final class ChatLoading extends ChatState {}

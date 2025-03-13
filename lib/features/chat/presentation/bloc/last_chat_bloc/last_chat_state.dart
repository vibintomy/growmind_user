import 'package:growmind/features/chat/domain/entities/chat.dart';

abstract class LastChatState {}

class LastChatInitial extends LastChatState {}

class LastChatLoading extends LastChatState {}

class LastChatLoaded extends LastChatState {
  final List<Chat> lastMessage;
  LastChatLoaded(this.lastMessage);
}

class LastChatError extends LastChatState {
  final String error;
  LastChatError(this.error);
}

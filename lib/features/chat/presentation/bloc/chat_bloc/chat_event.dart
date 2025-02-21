import 'package:equatable/equatable.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  final String receiverId;
  LoadMessages(this.receiverId);

  @override
  List<Object?> get props => [receiverId];
}

class SendMessages extends ChatEvent {
  final Message message;
  SendMessages(this.message);
  @override
  List<Object?> get props => [message];
}

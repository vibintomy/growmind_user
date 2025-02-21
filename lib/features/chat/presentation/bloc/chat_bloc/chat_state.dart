import 'package:equatable/equatable.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> message;
  ChatLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatError extends ChatState {}

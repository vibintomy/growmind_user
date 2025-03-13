import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timeStamp;
  final String? lastMessage;

  const Message(
      {required this.senderId,
      required this.receiverId,
      required this.message,
      required this.timeStamp,
      this.lastMessage});

  @override
  List<Object?> get props => [senderId, receiverId, message, timeStamp,lastMessage];
}

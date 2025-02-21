import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

class MessageModel extends Message {
  MessageModel(
      {required super.senderId,
      required super.receiverId,
      required super.message,
      required super.timeStamp});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        message: json['message'],
        timeStamp: json['timeStamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp
    };
  }

}

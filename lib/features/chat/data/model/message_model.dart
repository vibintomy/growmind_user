import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

class MessageModel extends Message {
  final String? id;
  MessageModel(
      {this.id,
      required String senderId,
      required String receiverId,
      required String message,
      required  DateTime timeStamp,
      required String lastMessage,
      })
      : super(
            senderId: senderId,
            receiverId: receiverId,
            message: message,
            timeStamp: timeStamp,
            lastMessage: lastMessage);
            factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timeStamp: (json['timeStamp'] as Timestamp).toDate(),
      lastMessage: json['lastMessage'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp,
      'lastMessage':lastMessage
    };
  }
}

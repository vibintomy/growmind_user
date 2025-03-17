import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

class MessageModel extends Message {
 
  MessageModel(
      {String? id,
      required String senderId,
      required String receiverId,
      required String message,
      required  DateTime timeStamp,
      required String lastMessage,
      })
      : super(
        id: id,
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
      'id':id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp,
      'lastMessage':lastMessage
    };
  }
}

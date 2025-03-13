import 'package:growmind/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind/features/chat/data/model/message_model.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';
import 'package:growmind/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepoImpl implements ChatRepositories {
  final ChatRemoteDatasource chatRemoteDatasource;
  ChatRepoImpl(this.chatRemoteDatasource);

  @override
  Stream<List<Message>> getMessage(String receiverId, String senderId) {
    return chatRemoteDatasource.getMessages(receiverId, senderId);
  }

  @override
  Future<void> sendMessage(Message message) async {
    final messageModel = MessageModel(
        senderId: message.senderId,
        receiverId: message.receiverId,
        message: message.message,
        timeStamp: message.timeStamp,
        lastMessage: message.lastMessage.toString());
    await chatRemoteDatasource.sendMessage(messageModel);
  }
}

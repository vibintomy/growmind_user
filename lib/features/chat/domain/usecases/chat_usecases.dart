import 'package:growmind/features/chat/domain/entities/chat_entites.dart';
import 'package:growmind/features/chat/domain/repositories/chat_repositories.dart';

class ChatUsecases {
  final ChatRepositories chatRepositories;
  ChatUsecases(this.chatRepositories);

  Stream<List<Message>> callReceiver(String receiverId) {
    return chatRepositories.getMessage(receiverId);
  }

  Future<void> callSender(Message message) {
    return chatRepositories.sendMessage(message);
  }
}

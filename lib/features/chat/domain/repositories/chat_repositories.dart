import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

abstract class ChatRepositories {
  Stream<List<Message>> getMessage(String receiverId);
  Future<void> sendMessage(Message message);
}

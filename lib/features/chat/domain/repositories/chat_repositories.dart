import 'package:growmind/features/chat/domain/entities/chat_entites.dart';

abstract class ChatRepositories {
  Stream<List<Message>> getMessage(String receiverId,String senderId);
  Future<void> sendMessage(Message message);
}

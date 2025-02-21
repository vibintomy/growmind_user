import 'package:growmind/features/chat/data/model/message_model.dart';

abstract class ChatRemoteDatasource {
  Stream<List<MessageModel>> getMessages(String receiverId);
  Future<void> sendMessage(MessageModel message);
}

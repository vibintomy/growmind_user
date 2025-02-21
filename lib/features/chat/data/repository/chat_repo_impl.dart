import 'package:growmind/features/chat/data/datasource/chat_remot_datasource_impl.dart';
import 'package:growmind/features/chat/data/model/message_model.dart';
import 'package:growmind/features/chat/domain/entities/chat_entites.dart';
import 'package:growmind/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepoImpl implements ChatRepositories {
  final ChatRemotDatasourceimpl remotDatasourceimpl;
  ChatRepoImpl(this.remotDatasourceimpl);

  @override
  Stream<List<Message>> getMessage(String receiverId) {
    return remotDatasourceimpl.getMessages(receiverId);
  }

  @override
  Future<void> sendMessage(Message message) {
    return remotDatasourceimpl.sendMessage(message as MessageModel);
  }
}

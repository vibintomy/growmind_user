import 'package:growmind/features/chat/domain/entities/chat.dart';
import 'package:growmind/features/chat/domain/repositories/last_chat_repositories.dart';

class LastChatUsecases {
  final LastChatRepositories lastChatRepositories;
  LastChatUsecases(this.lastChatRepositories);

  Future<List<Chat>> call(String id) {
    return lastChatRepositories.getLastMessage(id);
  }
}

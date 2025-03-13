import 'package:growmind/features/chat/domain/entities/chat.dart';

abstract class LastChatRepositories {
  Future<List<Chat>> getLastMessage(String userId);
}

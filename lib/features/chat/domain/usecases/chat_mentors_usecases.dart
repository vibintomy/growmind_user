import 'package:growmind/features/chat/domain/repositories/chat_mentor_repositories.dart';
import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

class ChatMentorsUsecases {
  final ChatMentorRepositories chatMentorRepositories;
  ChatMentorsUsecases(this.chatMentorRepositories);

  Future<List<TutorsEntity>> call(String userId) async {
    return await chatMentorRepositories.getTutor(userId: userId);
  }
}

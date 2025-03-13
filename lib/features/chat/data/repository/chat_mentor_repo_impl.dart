import 'package:growmind/features/chat/data/datasource/chat_mentor_datasource_impl.dart';
import 'package:growmind/features/chat/domain/repositories/chat_mentor_repositories.dart';
import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

class ChatMentorRepoImpl extends ChatMentorRepositories {
  final ChatMentorDatasourceImpl chatMentorDatasourceImpl;
  ChatMentorRepoImpl(this.chatMentorDatasourceImpl);

  @override
  Future<List<TutorsEntity>> getTutor({required String userId}) async {
    try {
      final tutorModel = await chatMentorDatasourceImpl.purchasedCourse(userId);
      if (tutorModel == null) {
        throw Exception('No User found');
      }

      List<TutorsEntity> tutorEntities = tutorModel.map((tutor) {
        return TutorsEntity(
            email: tutor.email,
            image: tutor.image,
            name: tutor.name,
            uid: tutor.uid,
            );
      }).toList();
      return tutorEntities;
    } catch (e) {
      throw Exception('NO values found for this profile');
    }
  }
}

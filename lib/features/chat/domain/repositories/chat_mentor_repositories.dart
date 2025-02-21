import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

abstract  class ChatMentorRepositories {
   Future<List<TutorsEntity>> getTutor({required String userId});
}
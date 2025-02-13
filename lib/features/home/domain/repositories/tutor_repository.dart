import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

abstract class TutorRepository {
  Future<TutorsEntity> getTutor({required String tutorId});
}

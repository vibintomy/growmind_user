import 'package:growmind/features/home/domain/entities/tutors_entity.dart';
import 'package:growmind/features/home/domain/repositories/tutor_repository.dart';

class GetTutorUsecases {
  final TutorRepository tutorRepository;
  GetTutorUsecases({required this.tutorRepository});
  Future<TutorsEntity> call(String tutorId) async {
    return tutorRepository.getTutor(tutorId: tutorId);
  }
}

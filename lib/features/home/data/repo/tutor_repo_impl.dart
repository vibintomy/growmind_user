import 'package:growmind/features/home/data/datasource/tutor_remote_datasource.dart';
import 'package:growmind/features/home/domain/entities/tutors_entity.dart';
import 'package:growmind/features/home/domain/repositories/tutor_repository.dart';

class TutorRepoImpl extends TutorRepository {
  final TutorRemoteDatasource tutorRemoteDatasource;
  TutorRepoImpl( {required this.tutorRemoteDatasource});

  @override
  Future<TutorsEntity> getTutor({required String tutorId}) async {
    try {
      final tutorModel = await tutorRemoteDatasource.fetchTutor(tutorId);
      if (tutorModel == null) {
        throw Exception('No User found');
      }

      return TutorsEntity(
          email: tutorModel.email,
          image: tutorModel.image,
          name: tutorModel.name,
          uid: tutorModel.uid);
    } catch (e) {
      throw Exception('NO values found for this profile');
    }
  }
}

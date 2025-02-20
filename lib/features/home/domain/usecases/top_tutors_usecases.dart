import 'package:growmind/features/home/domain/repositories/top_tutors_repo.dart';

class TopTutorsUsecases {
  final TopTutorsRepo topTutorsRepo;
  TopTutorsUsecases(this.topTutorsRepo);

  Future<List<Map<String, dynamic>>> call() async {
    return await topTutorsRepo.topTutors();
  }
}

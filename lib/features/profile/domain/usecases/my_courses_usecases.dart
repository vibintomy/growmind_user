import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/profile/domain/repo/my_courses_repo.dart';

class MyCoursesUsecases {
  final MyCoursesRepo myCoursesRepo;
  MyCoursesUsecases(this.myCoursesRepo);

  Future<List<CourseEntity>> call(String userId) {
    return myCoursesRepo.getMyCourse(userId);
  }
}

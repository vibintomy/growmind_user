import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/repositories/top_courses_repo.dart';

class TopCourseUsecases {
  final TopCoursesRepo topCoursesRepo;
  TopCourseUsecases(this.topCoursesRepo);

  Future<List<CourseEntity>> call() async {
    return await topCoursesRepo.fetchTopCourse();
  }
}

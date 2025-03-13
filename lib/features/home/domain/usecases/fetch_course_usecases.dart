import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/repositories/fetch_course_repo.dart';

class FetchCourseUsecases {
  final FetchCourseRepo courseRepo;
  FetchCourseUsecases(this.courseRepo);

  Future<List<CourseEntity>> call(String categoryId) async {
    return courseRepo.fetchCourse(categoryId);
  }

  Future<List<CourseEntity>> fetchAllCourse() async {
    return courseRepo.fetchAllCourse();
  }

  Future<List<CourseEntity>> searchCourses(String query) async {
    return courseRepo.searchCourses(query);
  }
}

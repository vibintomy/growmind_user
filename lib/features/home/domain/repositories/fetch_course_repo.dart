import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class FetchCourseRepo {
  Future<List<CourseEntity>> fetchCourse(String categoryId);
  Future<List<CourseEntity>> fetchAllCourse();
  Future<List<CourseEntity>> searchCourses(String query);
}

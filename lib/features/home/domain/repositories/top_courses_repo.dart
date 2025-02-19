import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class TopCoursesRepo {
  Future<List<CourseEntity>> fetchTopCourse();
}

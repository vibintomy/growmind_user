import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class MyCoursesRepo {
  Future<List<CourseEntity>> getMyCourse(String userId);
}

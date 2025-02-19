import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class TopCoursesState {}

class TopCourseInitial extends TopCoursesState {}

class TopCourseLoading extends TopCoursesState {}

class TopCourseLoaded extends TopCoursesState {
  final List<CourseEntity> topCourses;
  TopCourseLoaded(this.topCourses);
}

class TopCoureError extends TopCoursesState {
  final String error;
  TopCoureError(this.error);
}

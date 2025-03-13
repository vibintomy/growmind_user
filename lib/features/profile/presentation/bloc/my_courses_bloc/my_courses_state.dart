import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class MyCoursesState {}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCourseLoaded extends MyCoursesState {
  final List<CourseEntity> courses;
  MyCourseLoaded(this.courses);
}

class MyCourseError extends MyCoursesState {
  final String error;
  MyCourseError(this.error);
}

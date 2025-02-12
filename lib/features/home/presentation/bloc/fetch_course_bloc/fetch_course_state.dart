import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> allCourses;
  final List<CourseEntity> filteredCourses;
  final String? selectedFilter;
  CourseLoaded(this.allCourses,this.filteredCourses,this.selectedFilter);
}

class CourseError extends CourseState {
  final String Error;
  CourseError(this.Error);
}

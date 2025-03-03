import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class FavoriteState {}

class FavoriteStateInitial extends FavoriteState {}

class FavoriteStateLoading extends FavoriteState {}

class FavoriteStateLoaded extends FavoriteState {
  final List<CourseEntity> favoriteCourses;
  
  FavoriteStateLoaded({required this.favoriteCourses});
}

class IsFavoriteState extends FavoriteState {
  final bool isfavorite;
  final String courseId;
  
  IsFavoriteState({required this.isfavorite, required this.courseId});
}

class FavoriteError extends FavoriteState {
  final String error;
  
  FavoriteError(this.error);
}
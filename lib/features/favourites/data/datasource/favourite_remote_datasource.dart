import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class FavouriteRemoteDatasource {
  Future<List<String>> getFavouriteCourseIds(String userId);
  Future<void> toggleFavorite(String userId, String courseId);
  Future<bool> isFavorite(String userId, String courseId);
  Future<List<CourseEntity>> fetchCourse(String courseId);
}

import 'package:growmind/features/home/domain/entities/course_entity.dart';

abstract class FavouriteRepository {
  Future<List<String>> getFavouriteCourseIds(String userId);
  Future<void> toggleFavourite(String userId, String courseId);
  Future<bool> isFavourite(String userId, String courseId);
   Future<List<CourseEntity>> fetchCourse(String courseId);
}

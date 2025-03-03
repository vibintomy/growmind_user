import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';

class FetchFavoriteCourseUsecase {
  final FavouriteRepository favouriteRepository;
  FetchFavoriteCourseUsecase(this.favouriteRepository);
  Future<List<CourseEntity>> fetchCourse(String courseId) async {
    return await favouriteRepository.fetchCourse(courseId);
  }
}

import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';

class GetFavouriteCourse {
  final FavouriteRepository favouriteRepository;
  GetFavouriteCourse(this.favouriteRepository);
  Future<List<String>> call(String userId) {
    return favouriteRepository.getFavouriteCourseIds(userId);
  }
}

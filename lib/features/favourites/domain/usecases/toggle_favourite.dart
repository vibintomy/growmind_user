import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';

class ToggleFavourite {
  final FavouriteRepository favouriteRepository;
  ToggleFavourite(this.favouriteRepository);
  Future<void> call(String userId, String courseId) {
    return favouriteRepository.toggleFavourite(userId, courseId);
  }
}

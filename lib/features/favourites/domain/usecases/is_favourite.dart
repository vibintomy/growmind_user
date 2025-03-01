import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';

class IsFavourite {
  final FavouriteRepository favouriteRepository;
  IsFavourite(this.favouriteRepository);
  Future<bool> call(String userId, String courseId) {
    return favouriteRepository.isFavourite(userId, courseId);
  }
}

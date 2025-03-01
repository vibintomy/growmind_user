import 'package:growmind/features/favourites/data/datasource/favourite_remote_datasource.dart';
import 'package:growmind/features/favourites/domain/repositories/favourite_repository.dart';

class FavoriteRepoImpl implements FavouriteRepository {
  final FavouriteRemoteDatasource favouriteRemoteDatasource;

  FavoriteRepoImpl(this.favouriteRemoteDatasource);
  @override
  Future<List<String>> getFavouriteCourseIds(String userId) async {
    return favouriteRemoteDatasource.getFavouriteCourseIds(userId);
  }

  @override
  Future<void> toggleFavourite(String userId, String courseId) async {
    return favouriteRemoteDatasource.toggleFavorite(userId, courseId);
  }

  @override
  Future<bool> isFavourite(String userId, String courseId) async {
    return favouriteRemoteDatasource.isFavorite(userId, courseId);
  }
}

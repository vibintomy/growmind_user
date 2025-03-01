abstract class FavouriteRepository {
  Future<List<String>> getFavouriteCourseIds(String userId);
  Future<void> toggleFavourite(String userId, String courseId);
  Future<bool> isFavourite(String userId, String courseId);
}

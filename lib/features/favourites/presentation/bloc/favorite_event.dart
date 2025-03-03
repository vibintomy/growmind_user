abstract class FavoriteEvent {}

class LoadFavoriteEvent extends FavoriteEvent {
  final String userId;
  LoadFavoriteEvent({required this.userId});
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final String userId;
  final String courseId;
  ToggleFavoriteEvent({required this.userId, required this.courseId});
}

class SearchCourseEvent extends FavoriteEvent {
  final String query;
  SearchCourseEvent(this.query);
}

class CheckFavoriteEvent extends FavoriteEvent {
  final String userId;
  final String courseId;
  CheckFavoriteEvent({required this.userId, required this.courseId});
}

class SortByPriceEvent extends FavoriteEvent {}

class FilterByCategoryEvent extends FavoriteEvent {
  final String category;
  FilterByCategoryEvent(this.category);
}
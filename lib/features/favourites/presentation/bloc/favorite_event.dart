abstract class FavoriteEvent {}

class LoadFavoriteEvent extends FavoriteEvent {
  final String userId;
  LoadFavoriteEvent(this.userId);
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final String userId;
  final String courseId;
  ToggleFavoriteEvent(this.courseId, this.userId);
}

class CheckFavoriteEvent extends FavoriteEvent {
  final String userId;
  final String courseId;
  CheckFavoriteEvent(this.userId, this.courseId);
}

abstract class FavoriteState {}

class FavoriteStateInitial extends FavoriteState {}

class FavoriteStateLoading extends FavoriteState {}

class FavoriteStateLoaded extends FavoriteState {
  final List<String> favoriteCourseId;
  FavoriteStateLoaded(this.favoriteCourseId);
}

class IsFavoriteState extends FavoriteState {
  final bool isfavorite;
  final String courseId;
  IsFavoriteState(this.isfavorite, this.courseId);
}

class FavoriteError extends FavoriteState {
  final String error;
  FavoriteError(this.error);
}

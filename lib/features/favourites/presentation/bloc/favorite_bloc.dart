import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/favourites/domain/usecases/get_favourite_course.dart';
import 'package:growmind/features/favourites/domain/usecases/is_favourite.dart';
import 'package:growmind/features/favourites/domain/usecases/toggle_favourite.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavouriteCourse getFavouriteCourse;
  final IsFavourite isFavourite;
  final ToggleFavourite toggleFavourite;
  List<String> favoriteCourseIds = [];
  FavoriteBloc(
      {required this.getFavouriteCourse,
      required this.isFavourite,
      required this.toggleFavourite})
      : super(FavoriteStateInitial()) {
    on<LoadFavoriteEvent>(onLoadFavorites);
    on<ToggleFavoriteEvent>(onToggleState);
    on<CheckFavoriteEvent>(checkIsFavorite);
  }

  Future<void> onLoadFavorites(
      LoadFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteStateLoading());
    try {
      favoriteCourseIds = await getFavouriteCourse(event.userId);
      emit(FavoriteStateLoaded(favoriteCourseIds));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> onToggleState(
      ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      await toggleFavourite(event.userId, event.courseId);
      if (favoriteCourseIds.contains(event.courseId)) {
        favoriteCourseIds.remove(event.courseId);
      } else {
        favoriteCourseIds.add(event.courseId);
      }
      emit(FavoriteStateLoaded(favoriteCourseIds));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> checkIsFavorite(
      CheckFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final isFavorite = await isFavourite(event.userId, event.courseId);
      emit(IsFavoriteState(isFavorite, event.courseId));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}

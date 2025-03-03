import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/favourites/domain/usecases/fetch_favorite_course_usecase.dart';
import 'package:growmind/features/favourites/domain/usecases/get_favourite_course.dart';
import 'package:growmind/features/favourites/domain/usecases/is_favourite.dart';
import 'package:growmind/features/favourites/domain/usecases/toggle_favourite.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavouriteCourse getFavouriteCourse;
  final IsFavourite isFavourite;
  final ToggleFavourite toggleFavourite;
  final FetchFavoriteCourseUsecase fetchFavoriteCourseUsecase;

  List<CourseEntity> favoriteCourses = [];
  List<CourseEntity> filteredCourses = [];

  FavoriteBloc({
    required this.getFavouriteCourse,
    required this.fetchFavoriteCourseUsecase,
    required this.isFavourite,
    required this.toggleFavourite,
  }) : super(FavoriteStateInitial()) {
    on<LoadFavoriteEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<CheckFavoriteEvent>(_onCheckFavorite);
    on<SearchCourseEvent>(_onSearchEvent);
    on<SortByPriceEvent>(_onSortByPrice);
    on<FilterByCategoryEvent>(_onFilterByCategory);
  }

  Future<void> _onLoadFavorites(LoadFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteStateLoading());
    try {
      final List<String> favoriteCourseIds = await getFavouriteCourse(event.userId);
      if (favoriteCourseIds.isEmpty) {
        emit(FavoriteStateLoaded(favoriteCourses: []));
        return;
      }

      final List<CourseEntity> fetchedCourses = [];
      for (String courseId in favoriteCourseIds) {
        final List<CourseEntity> courses = await fetchFavoriteCourseUsecase.fetchCourse(courseId);
        fetchedCourses.addAll(courses);
      }
      
      favoriteCourses = fetchedCourses;
      emit(FavoriteStateLoaded(favoriteCourses: favoriteCourses));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      await toggleFavourite(event.userId, event.courseId);
      final isNowFavorite = await isFavourite(event.userId, event.courseId);
      emit(IsFavoriteState(isfavorite: isNowFavorite, courseId: event.courseId));
      if (isNowFavorite) {
        final List<CourseEntity> newFavorite = await fetchFavoriteCourseUsecase.fetchCourse(event.courseId);
        favoriteCourses.addAll(newFavorite);
      } else {
        favoriteCourses.removeWhere((course) => course.id == event.courseId);
      }
      emit(FavoriteStateLoaded(favoriteCourses: favoriteCourses));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onCheckFavorite(CheckFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final isFavorite = await isFavourite(event.userId, event.courseId);
      emit(IsFavoriteState(isfavorite: isFavorite, courseId: event.courseId));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onSearchEvent(SearchCourseEvent event, Emitter<FavoriteState> emit) async {
    final query = event.query.toLowerCase();
    filteredCourses = favoriteCourses.where((course) => course.courseName.toLowerCase().contains(query)).toList();
    emit(FavoriteStateLoaded(favoriteCourses: filteredCourses));
  }

  Future<void> _onSortByPrice(SortByPriceEvent event, Emitter<FavoriteState> emit) async {
    favoriteCourses.sort((a, b) => a.coursePrice.compareTo(b.coursePrice));
    emit(FavoriteStateLoaded(favoriteCourses: favoriteCourses));
  }

  Future<void> _onFilterByCategory(FilterByCategoryEvent event, Emitter<FavoriteState> emit) async {
    filteredCourses = favoriteCourses.where((course) => course.subCategory == event.category).toList();
    emit(FavoriteStateLoaded(favoriteCourses: filteredCourses));
  }
}

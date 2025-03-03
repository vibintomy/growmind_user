import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_event.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';

class FetchCourseBloc extends Bloc<CourseEvent, CourseState> {
  final FetchCourseUsecases fetchCourseUsecases;
  List<CourseEntity> allCourse = [];
  List<CourseEntity> filteredCourse = [];
  String? selectedFilter;
  FetchCourseBloc(this.fetchCourseUsecases) : super(CourseInitial()) {
    on<FetchCourseEvent>((event, emit) async {
      emit(CourseLoading());
      try {
        final course = await fetchCourseUsecases.call(event.categoryId);
        allCourse = course;
        filteredCourse = course;
        emit(CourseLoaded(allCourse, filteredCourse, selectedFilter));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
    on<FetchAllCourseEvent>((event, emit) async {
      emit(CourseLoading());
      try {
        final course = await fetchCourseUsecases.fetchAllCourse();
        allCourse = course;
        filteredCourse = course;
        emit(CourseLoaded(allCourse, filteredCourse, selectedFilter));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
    on<SearchCourseEvent>((event, emit) async {
      final query = event.query.toLowerCase();
      filteredCourse = allCourse
          .where((course) => course.courseName.toLowerCase().contains(query))
          .toList();
      emit(CourseLoaded(allCourse, filteredCourse, selectedFilter));
    });
    on<FilterSubCatCourse>((event, emit) {
      selectedFilter = event.subCategory;
      filteredCourse = selectedFilter == null
          ? allCourse
          : allCourse
              .where((course) => course.subCategory == selectedFilter)
              .toList();
      emit(CourseLoaded(allCourse, filteredCourse, selectedFilter));
    });
  }
}

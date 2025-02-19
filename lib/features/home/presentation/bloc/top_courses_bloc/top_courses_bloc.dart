import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/usecases/top_course_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_event.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_state.dart';

class TopCoursesBloc extends Bloc<TopCoursesEvent, TopCoursesState> {
  final TopCourseUsecases topCourseUsecases;
  TopCoursesBloc(this.topCourseUsecases) : super(TopCourseInitial()) {
    on<FetchTopCourseEvent>((event, emit) async {
      emit(TopCourseLoading());
      try {
        final courses = await topCourseUsecases.call();
        emit(TopCourseLoaded(courses));
      } catch (e) {
        emit(TopCoureError(e.toString()));
      }
    });
  }
}

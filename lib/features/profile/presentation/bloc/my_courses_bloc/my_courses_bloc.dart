import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/profile/domain/usecases/my_courses_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_event.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_state.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final MyCoursesUsecases myCoursesUsecases;
  MyCoursesBloc(this.myCoursesUsecases) : super(MyCoursesInitial()) {
    on<GetMyCoursesEvent>((event, emit) async {
      emit(MyCoursesLoading());
      try {
        final courses = await myCoursesUsecases.call(event.userId);
        emit(MyCourseLoaded(courses));
      } catch (e) {
        emit(MyCourseError(e.toString()));
      }
    });
  }
}

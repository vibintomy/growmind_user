import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/usecases/top_tutors_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_event.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_state.dart';

class TopTutorsBloc extends Bloc<TopTutorsEvent, TopTutorsState> {
  final TopTutorsUsecases topTutorsUsecases;
  TopTutorsBloc(this.topTutorsUsecases) : super(TopTutorInitial()) {
    on<GetTopTutorsEvent>((event, emit) async {
      emit(TopTutorLoading());
      try {
        final topTutor = await topTutorsUsecases.call();
        emit(TopTutorLoaded(topTutor));
      } catch (e) {
        throw Exception('failed to load tutors');
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/usecases/get_tutor_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_event.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_state.dart';

class TutorBloc extends Bloc <TutorEvent,TutorState>{
  final GetTutorUsecases getTutorUsecases;
  TutorBloc( {required this.getTutorUsecases}) : super(TutorStateInitial()) {
    on<GetTutorEvent>((event, emit) async {
      emit(TutorStateLoading());
      try {
        final tutorValues = await getTutorUsecases.call(event.tutorId);
        emit(TutorStateLoaded(tutorValues));
      } catch (e) {
        throw Exception('No values can be fetched');
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/chat/domain/usecases/chat_mentors_usecases.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_event.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_state.dart';
import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  final ChatMentorsUsecases chatMentorsUsecases;
  List<TutorsEntity> newList = [];
  MentorBloc(this.chatMentorsUsecases) : super(MentorInitial()) {
    on<GetMentor>((event, emit) async {
      emit(MentorLoading());
      try {
        final tutor = await chatMentorsUsecases.call(event.userId);
        emit(MentorLoaded(tutor));
        newList = tutor;
      } catch (e) {
        throw Exception('Unable to fetch the tutor details $e');
      }
    });

    on<SearchMentor>((event, emit) {
      final filteredTutors = newList.where(
          (ele) => ele.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(MentorLoaded(filteredTutors));
    });
  }
}

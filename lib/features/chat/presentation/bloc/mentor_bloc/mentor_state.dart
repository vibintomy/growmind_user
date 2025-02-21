import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

abstract class MentorState {}

class MentorInitial extends MentorState {}

class MentorLoading extends MentorState {}

class MentorLoaded extends MentorState {
  final List<TutorsEntity> tutors;
  MentorLoaded(this.tutors);
}

class MentorError extends MentorState {
  final String error;
  MentorError(this.error);
}

import 'package:growmind/features/home/domain/entities/tutors_entity.dart';

abstract class TutorState {}

class TutorStateInitial extends TutorState {}

class TutorStateLoading extends TutorState {}

class TutorStateLoaded extends TutorState {
  final TutorsEntity tutorId;
  TutorStateLoaded(this.tutorId);
}

class TutorStateError extends TutorState {
  final String error;
  TutorStateError(this.error);
}

abstract class TutorEvent {}

class GetTutorEvent extends TutorEvent {
  final String tutorId;
  GetTutorEvent(this.tutorId);
}

abstract class MyCoursesEvent {}

class GetMyCoursesEvent extends MyCoursesEvent {
  final String userId;
  GetMyCoursesEvent({required this.userId});
}

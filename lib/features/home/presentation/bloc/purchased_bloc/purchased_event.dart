abstract class PurchasedEvent {}

class PurchasedCourseEvent extends PurchasedEvent {
  final String userId;
  PurchasedCourseEvent(this.userId);
}

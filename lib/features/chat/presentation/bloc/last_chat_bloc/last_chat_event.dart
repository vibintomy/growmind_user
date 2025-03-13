abstract class LastChatEvent {}

class GetLastChatEvent extends LastChatEvent {
  final String userId;
  GetLastChatEvent(this.userId);
}

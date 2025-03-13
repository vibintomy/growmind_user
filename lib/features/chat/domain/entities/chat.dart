class Chat {
  final String id;
  final List<String> participants;
  final String lastMessage;

  Chat(
      {required this.id,
      required this.lastMessage,
      required this.participants});
}

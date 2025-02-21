abstract class MentorEvent {}

class GetMentor extends MentorEvent {
  final String userId;
  GetMentor({required this.userId});
}

class SearchMentor extends MentorEvent {
  final String query;
  SearchMentor(this.query);
}

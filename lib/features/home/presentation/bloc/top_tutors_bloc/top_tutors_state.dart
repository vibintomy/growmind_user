abstract class TopTutorsState {}

class TopTutorInitial extends TopTutorsState {}

class TopTutorLoading extends TopTutorsState {}

class TopTutorLoaded extends TopTutorsState {
 final List<Map<String, dynamic>> tutors;
  TopTutorLoaded(this.tutors);
}

class TopTutorError extends TopTutorsState {
  final String error;
  TopTutorError(this.error);
}

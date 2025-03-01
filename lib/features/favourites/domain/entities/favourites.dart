class Favourites {
  final String id;
  final String userId;
  final String courseId;
  final DateTime createdAt;

  Favourites(
      {required this.id,
      required this.userId,
      required this.courseId,
      required this.createdAt});
}

import 'package:growmind/features/favourites/domain/entities/favourites.dart';

class FavoriteModel extends Favourites {
  FavoriteModel({
    required String id,
    required String userId,
    required String courseId,
    required DateTime createdAt,
  }) : super(
          id: id,
          userId: userId,
          courseId: courseId,
          createdAt: createdAt,
        );

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
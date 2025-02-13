class TutorModel {
  final String name;
  final String image;
  final String email;
  final String uid;

  TutorModel(
      {required this.name,
      required this.image,
      required this.email,
      required this.uid});
  factory TutorModel.fromFireStore(Map<String, dynamic> json) {
    return TutorModel(
        name: json['displayName'],
        image: json['imageUrl'],
        email: json['email'],
        uid: json['uid']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'email': email, 'uid': uid};
  }
}

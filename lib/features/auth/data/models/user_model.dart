class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String phone;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.phone,
    this.imageUrl
  });

  factory UserModel.fromFirebaseUser(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      phone: json['phone'],
      imageUrl: json['imageUrl']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phone': phone,
      'imageUrl':imageUrl
    };
  }
}

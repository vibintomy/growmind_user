class CategoriesModel {
  final String id;
  final String category;
  final String imageUrl;
  CategoriesModel(
      {required this.id, required this.category, required this.imageUrl});
  factory CategoriesModel.fromFireStore(Map<String, dynamic> json) {
    return CategoriesModel(
        id: json['id'] ?? "",
        category: json['category'] ?? "",
        imageUrl: json['imageUrl'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'category': category, 'imageUrl': imageUrl};
  }
}

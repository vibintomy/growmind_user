import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/data/models/categories_model.dart';

class CategoriesRemoteDatasource {
  final FirebaseFirestore firestore;
  CategoriesRemoteDatasource(this.firestore);
  Future<List<CategoriesModel>> displayCourse() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('category').get();

      return snapshot.docs
          .map((doc) => CategoriesModel.fromFireStore(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('No values found ');
    }
  }

  Future<List<SubCategoriesModel>> subCategories(String categoryId) async {
    if (categoryId.isEmpty) {
      print('no values');
    } else {
      print(categoryId);
    }
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('category')
          .doc(categoryId)
          .collection('subcategory')
          .get();
      return snapshot.docs
          .map((doc) => SubCategoriesModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('No values found');
    }
  }
}

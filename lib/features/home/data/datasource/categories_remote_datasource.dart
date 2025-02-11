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
}

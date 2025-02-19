import 'package:cloud_firestore/cloud_firestore.dart';

class PurchasedCourseDatasource {
  final FirebaseFirestore firestore;
  PurchasedCourseDatasource(this.firestore);

  Future<List<String>> purchasedCourse(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      List<String> purchasedCourse =
          List<String>.from(documentSnapshot.get('purchasedCourses') ?? []);
      return purchasedCourse;
    }
    return [];
  }
}

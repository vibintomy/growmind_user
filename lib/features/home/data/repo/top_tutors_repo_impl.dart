import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/domain/repositories/top_tutors_repo.dart';

class TopTutorsRepoImpl implements TopTutorsRepo {
  final FirebaseFirestore firestore;
  TopTutorsRepoImpl(this.firestore);
  @override
  Future<List<Map<String, dynamic>>> topTutors() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('tutors')
          .orderBy('totalusers', descending: true)
          .limit(5)
          .get();
      List<Map<String, dynamic>> topUsers = querySnapshot.docs.map((doc) {
        return {
          'uid': doc.id,
          'displayName': doc['displayName'] ?? '',
          'imageUrl': doc['imageUrl'] ?? ''
        };
      }).toList();
      return topUsers;
    } catch (e) {
      throw Exception('Error in fetching tutor details $e');
    }
  }
}

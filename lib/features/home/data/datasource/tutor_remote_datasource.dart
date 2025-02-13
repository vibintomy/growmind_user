import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/data/models/tutor_model.dart';

class TutorRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  TutorRemoteDatasource(this.firebaseFirestore);
  Future<TutorModel> fetchTutor(String tutorId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('tutors').doc(tutorId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return TutorModel.fromFireStore(snapshot.data()!);
      } else {
        throw Exception('No values in the collection');
      }
    } catch (e) {
      throw Exception('No values found ');
    }
  }
}

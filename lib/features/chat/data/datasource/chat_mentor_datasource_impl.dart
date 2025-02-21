import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/data/models/tutor_model.dart';

class ChatMentorDatasourceImpl {
  final FirebaseFirestore firestore;
  ChatMentorDatasourceImpl(this.firestore);

  Future<List<TutorModel>> purchasedCourse(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      List<String> tutor =
          List<String>.from(documentSnapshot.get('mentor') ?? []);
      List<TutorModel> tutorDetails = [];
      for (String tutorId in tutor) {
        DocumentSnapshot tutorDoc =
            await firestore.collection('tutors').doc(tutorId).get();
        if (tutorDoc.exists && tutorDoc.data() != null) {
          TutorModel tutor = TutorModel.fromFireStore(tutorDoc.data() as Map<String,dynamic>);
          tutorDetails.add(tutor);
        }
      }
      return tutorDetails;
    }
    return [];
  }
}

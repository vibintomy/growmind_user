import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:growmind/features/profile/data/models/profile_model.dart';

class ProfileRemoteDatasource {
  final FirebaseFirestore firestore;

  ProfileRemoteDatasource(this.firestore);

  Future<ProfileModel> fetchProfile(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(userId).get();

      // Check if the document exists
      if (snapshot.exists && snapshot.data() != null) {
        return ProfileModel.fromFirestore(snapshot.data()!);
      } else {
        // Document does not exist, return null or handle as needed
        throw Exception('profile data does not exists for userId $userId');
      }
    } catch (e) {
      // Handle exceptions appropriately
      print('Error fetching profile: $e');
      throw Exception('Failed to fetch profile: $e');
    }
  }
}

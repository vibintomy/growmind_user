import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class ProfileService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    try {
      await firestore
          .collection('profiles')
          .doc(userId)
          .update({'imageUrl': imageUrl});
      print('profile image update successfull');
    } catch (e) {
      print('Error updating profile image :$e');
      throw Exception('Failed to upload profile Image');
    }
  }
}

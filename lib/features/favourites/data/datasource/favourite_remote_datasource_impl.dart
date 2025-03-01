import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/favourites/data/datasource/favourite_remote_datasource.dart';
import 'package:growmind/features/favourites/data/model/favourite.dart';

class FavouriteRemoteDatasourceImpl implements FavouriteRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  FavouriteRemoteDatasourceImpl(this.firebaseFirestore);
  @override
  Future<List<String>> getFavouriteCourseIds(String userId) async {
    final snapshot = await firebaseFirestore
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((docs) => docs.data()['courseId'] as String)
        .toList();
  }

  @override
  Future<void> toggleFavorite(String userId, String courseId) async {
    final favreq = await firebaseFirestore.collection('favorites');

    final querysnapshot = await favreq
        .where('userId', isEqualTo: userId)
        .where('courseId', isEqualTo: courseId)
        .limit(1)
        .get();
    if (querysnapshot.docs.isNotEmpty) {
      await favreq.doc(querysnapshot.docs.first.id).delete();
    } else {
      final favorite = FavoriteModel(
              id: favreq.doc().id,
              userId: userId,
              courseId: courseId,
              createdAt: DateTime.now())
          .toJson();
      await favreq.doc(favorite['id']).set(favorite);
    }
  }

  @override
  Future<bool> isFavorite(String userId, String courseId) async {
    final querysnapshot = await firebaseFirestore
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .where('courseId', isEqualTo: courseId)
        .limit(1)
        .get();
    return querysnapshot.docs.isNotEmpty;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:growmind/features/favourites/data/datasource/favourite_remote_datasource.dart';
import 'package:growmind/features/favourites/data/model/favourite.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';

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

   @override
  Future<List<CourseEntity>> fetchCourse(String courseId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('courses')
          .where('id', isEqualTo: courseId)
          .get();
      List<CourseEntity> courses = [];
      for (var doc in querySnapshot.docs) {
        final sectionSnapshot = await firebaseFirestore
            .collection('courses')
            .doc(doc.id)
            .collection('sections')
            .get();
        List<SectionEntity> sections = sectionSnapshot.docs.map((sectionDoc) {
          return SectionEntity(
              id: sectionDoc.id,
              videoUrl: sectionDoc['videoUrl'],
              sectionName: sectionDoc['sectionName'],
              sectionDescription: sectionDoc['sectionDescription'],
              createdAt:
                  (sectionDoc['createdAt'] as Timestamp).asDate().toString());
        }).toList();
        courses.add(CourseEntity(
            id: doc.id,
            category: doc['category'],
            courseName: doc['courseName'],
            courseDescription: doc['courseDescription'],
            coursePrice: doc['coursePrice'],
            imageUrl: doc['imageUrl'],
            subCategory: doc['subCategory'],
            createdBy: doc['createdBy'],
            createdAt: (doc['createdAt'] as Timestamp).toDate().toString(),
            sections: sections));
      }
      return courses;
    } catch (e, stackTrace) {
      throw Exception('Error fetching course');
    }
  }

}

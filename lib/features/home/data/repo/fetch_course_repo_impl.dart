import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/domain/repositories/fetch_course_repo.dart';

class FetchCourseRepoimpl extends FetchCourseRepo {
  final FirebaseFirestore firestore;
  FetchCourseRepoimpl(this.firestore);

  @override
  Future<List<CourseEntity>> fetchCourse(String categoryId) async {
    try {
      final querySnapshot = await firestore
          .collection('courses')
          .where('category', isEqualTo: categoryId)
          .get();
      List<CourseEntity> courses = [];
      for (var doc in querySnapshot.docs) {
        final sectionSnapshot = await firestore
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

  @override
  Future<List<CourseEntity>> fetchAllCourse() async {
    try {
      final querysnapshot = await firestore.collection('courses').get();
      List<CourseEntity> courses = [];
      for (var doc in querysnapshot.docs) {
        final sectionSnapShot = await firestore
            .collection('courses')
            .doc(doc.id)
            .collection('sections')
            .get();
        List<SectionEntity> sections = sectionSnapShot.docs.map((sectionDoc) {
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
    } catch (e) {
      throw Exception('Error Fetching all courses');
    }
  }
}

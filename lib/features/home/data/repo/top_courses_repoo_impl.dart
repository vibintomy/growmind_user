import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/domain/repositories/top_courses_repo.dart';

class TopCoursesRepoImpl implements TopCoursesRepo {
  final FirebaseFirestore firestore;
  TopCoursesRepoImpl(this.firestore);

  @override
  Future<List<CourseEntity>> fetchTopCourse() async {
    try {
      final querySnapshot = await firestore
          .collection('courses')
          .orderBy('purchasesCount', descending: true)
          .limit(3)
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
              createdAt: sectionDoc['createdAt']);
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
      print('Error fetching top courses $StackTrace');
      throw Exception('Error in while fetching data from the courses');
    }
  }
}

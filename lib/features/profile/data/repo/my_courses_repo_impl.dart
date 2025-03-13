import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/profile/domain/repo/my_courses_repo.dart';

class MyCoursesRepoImpl implements MyCoursesRepo {
  final FirebaseFirestore firebaseFirestore;
  MyCoursesRepoImpl(this.firebaseFirestore);

    @override
  Future<List<CourseEntity>> getMyCourse(String userId) async {
    try {
      final userDoc = await firebaseFirestore.collection('users').doc(userId).get();     
      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      
      List<String> purchasedCourseIds = List<String>.from(userDoc['purchasedCourses'] ?? []);
      
      if (purchasedCourseIds.isEmpty) {
        return [];
      }
      List<CourseEntity> allCourses = [];
      
      for (String courseId in purchasedCourseIds) {
        final courses = await fetchCourse(courseId);
        allCourses.addAll(courses);
      }
      
      return allCourses;
    } catch (e) {
      throw Exception('Error fetching purchased courses: ${e.toString()}');
    }
  }

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
              createdAt: (sectionDoc['createdAt'] as Timestamp).toDate().toString());
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
      throw Exception('Error fetching course: ${e.toString()}');
    }
  }
}

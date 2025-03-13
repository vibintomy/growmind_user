import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;
  
  const CourseCard({super.key, required this.course});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: course.imageUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            )
          : Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: const Icon(Icons.book),
            ),
        title: Text(
          course.courseName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              course.courseDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: mainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    course.category,
                    style:const TextStyle(
                      fontSize: 12,
                      color: mainColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$${course.coursePrice}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
     
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayCourse(id:course.id , category:  course.category, courseName: course.courseName, courseDescription: course.courseDescription, coursePrice: course.coursePrice, createdAt: course.createdAt, createdBy: course.createdBy, imageUrl: course.imageUrl, sections: course.sections, subCategory: course.subCategory),
            ),
          );
        },
      ),
    );
  }
}
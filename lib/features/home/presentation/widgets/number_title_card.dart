import 'package:flutter/material.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';
import 'package:growmind/features/home/presentation/widgets/name_card.dart';

class NumberTitleCard extends StatelessWidget {
  final List<CourseEntity> courses;
  const NumberTitleCard({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        LimitedBox(
          maxHeight: 200,
          maxWidth: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index]; // Get course details

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayCourse(
                        id: course.id,
                        category: course.category,
                        courseName: course.courseName,
                        courseDescription: course.courseDescription,
                        coursePrice: course.coursePrice,
                        createdAt: course.createdAt,
                        createdBy: course.createdBy,
                        imageUrl: course.imageUrl,
                        sections: course.sections,
                        subCategory: course.subCategory,
                      ),
                    ),
                  );
                },
                child: NumberCard(
                  url: course.imageUrl,
                  index: index,
                  courseName: course.subCategory, // Display subCategory
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

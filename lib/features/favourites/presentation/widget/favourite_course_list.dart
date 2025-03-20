// favorite_course_list.dart
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/favourites/presentation/pages/favoriteIcon.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';

class FavoriteCourseList extends StatelessWidget {
  final List<CourseEntity> courses;

  const FavoriteCourseList({
    Key? key,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return courses.isEmpty
        ? const Center(child: Text('No specified Course found'))
        : ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return buildCourseCard(context, courses[index]);
            },
          );
  }

  Widget buildCourseCard(BuildContext context, CourseEntity course) {
    return SizedBox(
      height: 180,
      child: Card(
        color: textColor,
        shadowColor: greyColor,
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildCourseImage(context, course),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildCourseDetails(course),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCourseImage(BuildContext context, CourseEntity course) {
    return Container(
      width: 150,
      height: 160,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 3,
            color: greyColor,
          )
        ],
        shape: BoxShape.rectangle,
        color: greyColor,
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
      child: GestureDetector(
        onTap: () => navigateToDetailPage(context, course),
        child: Image.network(
          course.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCourseDetails(CourseEntity course) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: FavoriteIcon(courseId: course.id),
        ),
        kwidth1,
        Text(
          course.subCategory,
          style: const TextStyle(
            color: mainColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        kheight1,
        Text(
          course.courseName,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Price - ${course.coursePrice}-/',
          style: const TextStyle(
            color: mainColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void navigateToDetailPage(BuildContext context, CourseEntity course) {
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
  }
}
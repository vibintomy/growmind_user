import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/widget/shimmer.dart';
import 'package:growmind/features/favourites/presentation/pages/favoriteIcon.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/my_courses_bloc/my_courses_state.dart';
import 'package:growmind/features/profile/presentation/widgets/custom_app_bar.dart';


class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CustomSliverAppBar(), 
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              kheight,
           const   Divider(
            height: 1,
            color: greyColor,
            thickness: 1,

           ),
              Expanded(
                child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                  builder: (context, state) {
                    if (state is MyCoursesLoading) {
                      return const Center(
                        child: ShimmerLoading(),
                      );
                    } else if (state is MyCourseLoaded) {
                      final course = state.courses;
                      return course.isEmpty
                          ? const Center(
                              child: Text(
                                'No Courses Available \n Purchase a course',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              itemCount: course.length,
                              itemBuilder: (context, index) {
                                final courses = course[index];
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
                                          child: Container(
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
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(1)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DisplayCourse(
                                                      id: courses.id,
                                                      category: courses.category,
                                                      courseName: courses.courseName,
                                                      courseDescription:
                                                          courses.courseDescription,
                                                      coursePrice: courses.coursePrice,
                                                      createdAt: courses.createdAt,
                                                      createdBy: courses.createdBy,
                                                      imageUrl: courses.imageUrl,
                                                      sections: courses.sections,
                                                      subCategory: courses.subCategory,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Image.network(
                                                courses.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: FavoriteIcon(courseId: courses.id),
                                                ),
                                                kwidth1,
                                                Text(
                                                  courses.subCategory,
                                                  style: const TextStyle(
                                                    color: mainColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                kheight1,
                                                Text(
                                                  courses.courseName,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Price - ${courses.coursePrice}-/',
                                                  style: const TextStyle(
                                                    color: mainColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                    return const Center(
                      child: Text('No data available'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

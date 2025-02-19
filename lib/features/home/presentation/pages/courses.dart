import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_event.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_event.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';

class Courses extends StatelessWidget {
  final String categoryId;
  final String id;
  const Courses({super.key, required this.categoryId, required this.id});

  @override
  Widget build(BuildContext context) {
    final courseBloc = context.read<FetchCourseBloc>();
    courseBloc.add(FetchCourseEvent(categoryId: categoryId));
 final user = FirebaseAuth.instance.currentUser;
    context.read<PurchasedBloc>().add(PurchasedCourseEvent(user!.uid));
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Course List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 350,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: textColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                        blurRadius: 3,
                        color: greyColor)
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.search,
                          color: textColor,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  context.read<FetchCourseBloc>().add(SearchCourseEvent(value));
                },
              ),
            ),
            kheight1,
            BlocBuilder<FetchCourseBloc, CourseState>(
                builder: (context, state) {
              if (state is CourseLoaded) {
                final subCategories = state.allCourses
                    .map((course) => course.subCategory)
                    .toSet()
                    .toList();
                subCategories.insert(0, "All");
                return Wrap(
                  spacing: 25,
                  children: subCategories.map((subCategory) {
                    final isSelected = state.selectedFilter == subCategory;
                    return ChoiceChip(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide.none),
                      label: Text(subCategory),
                      selected: isSelected,
                      selectedColor: textColor1,
                      backgroundColor: textColor,
                      labelStyle: TextStyle(
                          color: isSelected ? textColor : Colors.black),
                      onSelected: (bool isSelected) {
                        if (subCategory == "All") {
                          context
                              .read<FetchCourseBloc>()
                              .add(FilterSubCatCourse(null));
                        } else {
                          context
                              .read<FetchCourseBloc>()
                              .add(FilterSubCatCourse(subCategory));
                        }
                      },
                    );
                  }).toList(),
                );
              }
              return const Center(
                child: Text('no values'),
              );
            }),
            kheight1,
            BlocBuilder<FetchCourseBloc, CourseState>(
                builder: (context, state) {
              if (state is CourseLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CourseLoaded) {
                final courses = state.filteredCourses;
                return Expanded(
                  child: courses.isEmpty
                      ? const Center(
                          child: Text('No course Available'),
                        )
                      : ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return SizedBox(
                              height: 180,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayCourse(
                                                id:course.id,
                                                category: course.category,
                                                courseName: course.courseName,
                                                courseDescription: course.courseDescription,
                                                coursePrice: course.coursePrice,
                                                createdAt: course.createdAt,
                                                createdBy: course.createdBy,
                                                imageUrl: course.imageUrl,
                                                sections: course.sections,
                                                subCategory: course.subCategory,
                                              )));
                                },
                                child: Card(
                                    color: textColor,
                                    shadowColor: greyColor,
                                    elevation: 5,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      color: greyColor)
                                                ],
                                                shape: BoxShape.rectangle,
                                                color: greyColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1))),
                                            child: Image.network(
                                              course.imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                kheight2,
                                                kwidth1,
                                                Text(
                                                  course.subCategory,
                                                  style: const TextStyle(
                                                      color: mainColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                kheight1,
                                                Text(
                                                  course.courseName,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Price - ${course.coursePrice}-/',
                                                  style: const TextStyle(
                                                      color: mainColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          }),
                );
              } else if (state is CourseError) {
                return const Center(
                  child: Text('Error while Fetching data'),
                );
              }
              return const Center(
                child: Text('No Course is Available'),
              );
            })
          ],
        ),
      ),
    );
  }
}

// lib/features/favorites/presentation/pages/favorites_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';
import 'package:growmind/features/favourites/presentation/pages/favoriteIcon.dart';

import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    // Load favorite courses when page initializes
    context.read<FavoriteBloc>().add(LoadFavoriteEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Favorite Courses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, favoriteState) {
                if (favoriteState is FavoriteStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (favoriteState is FavoriteStateLoaded) {
                  final favoriteCourseIds = favoriteState.favoriteCourseId;
                  
                  if (favoriteCourseIds.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text('No favorite courses yet'),
                      ),
                    );
                  }

                  // We need to get the actual course data from the course BLoC
                  return BlocBuilder<FetchCourseBloc, CourseState>(
                    builder: (context, courseState) {
                      if (courseState is CourseLoaded) {
                        // Filter courses to only show those in the favorites list
                        final favoriteCourses = courseState.allCourses
                            .where((course) => favoriteCourseIds.contains(course.id))
                            .toList();

                        if (favoriteCourses.isEmpty) {
                          return const Expanded(
                            child: Center(
                              child: Text('No favorite courses found'),
                            ),
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: favoriteCourses.length,
                            itemBuilder: (context, index) {
                              final course = favoriteCourses[index];
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
                                                color: greyColor)
                                            ],
                                            shape: BoxShape.rectangle,
                                            color: greyColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(1))),
                                          child: GestureDetector(
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
                                            child: Image.network(
                                              course.imageUrl,
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
                                                child: FavoriteIcon(courseId: course.id),
                                              ),
                                              kwidth1,
                                              Text(
                                                course.subCategory,
                                                style: const TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                              ),
                                              kheight1,
                                              Text(
                                                course.courseName,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Price - ${course.coursePrice}-/',
                                                style: const TextStyle(
                                                  color: mainColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
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
                          ),
                        );
                      } else if (courseState is CourseLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load courses'),
                        );
                      }
                    },
                  );
                } else if (favoriteState is FavoriteError) {
                  return Center(
                    child: Text('Error: ${favoriteState.error}'),
                  );
                }
                return const Center(
                  child: Text('No favorite courses found'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
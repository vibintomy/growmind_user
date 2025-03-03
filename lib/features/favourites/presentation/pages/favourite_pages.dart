import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';
import 'package:growmind/features/favourites/presentation/pages/favoriteIcon.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';
import 'package:growmind/features/home/presentation/pages/display_course.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    context.read<FavoriteBloc>().add(LoadFavoriteEvent(userId: userId));
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
                  context.read<FavoriteBloc>().add(SearchCourseEvent(value));
                },
              ),
            ),
            kheight,
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                    // Drowpdownmenu()
                    },
                    icon: const Icon(Icons.filter_list_rounded))),
            kheight,
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, favoriteState) {
                  if (favoriteState is FavoriteStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (favoriteState is FavoriteStateLoaded) {
                    final List<CourseEntity> favoriteCourses =
                        favoriteState.favoriteCourses;
                    return favoriteCourses.isEmpty
                        ? Center(
                            child: Text('No specified Course found'),
                          )
                        : ListView.builder(
                            itemCount: favoriteCourses.length,
                            itemBuilder: (context, index) {
                              final CourseEntity course =
                                  favoriteCourses[index];
                              return SizedBox(
                                height: 180,
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
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DisplayCourse(
                                                              id: course.id,
                                                              category: course
                                                                  .category,
                                                              courseName: course
                                                                  .courseName,
                                                              courseDescription:
                                                                  course
                                                                      .courseDescription,
                                                              coursePrice: course
                                                                  .coursePrice,
                                                              createdAt: course
                                                                  .createdAt,
                                                              createdBy: course
                                                                  .createdBy,
                                                              imageUrl: course
                                                                  .imageUrl,
                                                              sections: course
                                                                  .sections,
                                                              subCategory: course
                                                                  .subCategory,
                                                            )));
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
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: FavoriteIcon(
                                                      courseId: course.id,
                                                    )),
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
                              );
                            },
                          );
                  }

                  return const Center(child: Text('No favorite courses found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

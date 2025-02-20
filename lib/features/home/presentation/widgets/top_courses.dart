
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_state.dart';
import 'package:growmind/features/home/presentation/widgets/number_title_card.dart';

BlocBuilder<TopCoursesBloc, TopCoursesState> topCourses() {
    return BlocBuilder<TopCoursesBloc, TopCoursesState>(
                builder: (context, state) {
                  if (state is TopCourseLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopCourseLoaded) {
                    final topCourse = state.topCourses;
                    return NumberTitleCard(courses: topCourse);
                  } else if (state is TopCoureError) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No values found'),
                  );
                },
              );
  }
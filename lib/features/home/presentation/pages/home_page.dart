
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_event.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_courses_bloc/top_courses_event.dart';
import 'package:growmind/features/home/presentation/pages/categories.dart';
import 'package:growmind/features/home/presentation/widgets/carousel_widget_page.dart';
import 'package:growmind/features/home/presentation/widgets/home_search.dart';
import 'package:growmind/features/home/presentation/widgets/index_indicator.dart';
import 'package:growmind/features/home/presentation/widgets/spinning_container.dart';
import 'package:growmind/features/home/presentation/widgets/top_courses.dart';
import 'package:growmind/features/home/presentation/widgets/top_mentors.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_event.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final CarouselController carouselController = CarouselController();
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profilebloc = context.read<ProfileBloc>();
    profilebloc.add(LoadProfileEvent(user!.uid ));
    context.read<PurchasedBloc>().add(PurchasedCourseEvent(user.uid));
    context.read<TopCoursesBloc>().add(FetchTopCourseEvent());
    return Scaffold(
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state is ProfileLoaded) {
                        final profile = state.profile;
                        return Text(
                          'Hi,${profile.displayName.toUpperCase()}👋',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const Text('');
                    }),
                   
                  ],
                ),
                const Text(
                  'What would like to learn Today?\nSearch Below.',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 112, 110, 110)),
                ),
                kheight1,
                homeSearch(context),
                kheight1,
                carouselWidget(currentIndex),
                kheight,
                indexIndicator(currentIndex: currentIndex),
                kheight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'SEE ALL',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: mainColor),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          size: 14,
                          color: mainColor,
                        )
                      ],
                    ),
                  ],
                ),
                kheight,
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Categories()));
                    },
                    child: spinningContainer()),
                kheight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top 3 Courses',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'view',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          size: 14,
                          color: mainColor,
                        ),
                      ],
                    )
                  ],
                ),
                kheight,
                topCourses(),
                kheight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Mentors',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'view',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          size: 14,
                          color: mainColor,
                        ),
                      ],
                    )
                  ],
                ),
                kheight,
                const TopMentors(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

 
}

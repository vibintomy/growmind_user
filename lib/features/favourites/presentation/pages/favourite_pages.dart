
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/widget/custom_search_widget.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';
import 'package:growmind/features/favourites/presentation/widget/favourite_course_list.dart';
import 'package:growmind/features/favourites/presentation/widget/filter_sorting.dart';


class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
   
    initializeFavorites(context);

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
        
            SearchWidget(
              onChanged: (value) {
                context.read<FavoriteBloc>().add(SearchCourseEvent(value));
              },
            ),
            kheight,

           
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteStateLoaded) {
                  return FilterSortBar(
                    courses: state.favoriteCourses,
                    selectedCategory: selectedCategory,
                    onSortPressed: () {
                      context.read<FavoriteBloc>().add(SortByPriceEvent());
                    },
                    onCategorySelected: (category) {
                      if (category != null) {
                        context.read<FavoriteBloc>().add(FilterByCategoryEvent(category));
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            kheight,

           
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavoriteStateLoaded) {
                    return FavoriteCourseList(
                      courses: state.favoriteCourses,
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

  void initializeFavorites(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    context.read<FavoriteBloc>().add(LoadFavoriteEvent(userId: userId));
  }
}
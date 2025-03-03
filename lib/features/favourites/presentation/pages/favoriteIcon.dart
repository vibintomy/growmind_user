import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';

class FavoriteIcon extends StatelessWidget {
  final String courseId;

  const FavoriteIcon({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

 

    return BlocSelector<FavoriteBloc, FavoriteState, bool>(
      selector: (state) {
        if (state is IsFavoriteState && state.courseId == courseId) {
          return state.isfavorite;
        } else if (state is FavoriteStateLoaded) {
          return state.favoriteCourses.any((course) => course.id == courseId);
        }
        return false;
      },
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () {
            context.read<FavoriteBloc>().add(
                  ToggleFavoriteEvent(userId: userId, courseId: courseId),
                );
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: isFavorite ? Colors.red : null,
          ),
        );
      },
    );
  }
}

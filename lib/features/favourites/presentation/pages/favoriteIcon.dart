
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_bloc.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_event.dart';
import 'package:growmind/features/favourites/presentation/bloc/favorite_state.dart';

class FavoriteIcon extends StatefulWidget {
  final String courseId;

  const FavoriteIcon({Key? key, required this.courseId}) : super(key: key);

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    // Check if course is favorite when widget is initialized
    context.read<FavoriteBloc>().add(CheckFavoriteEvent(userId, widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        
        // If we have a specific check for this course
        if (state is IsFavoriteState && state.courseId == widget.courseId) {
          isFavorite = state.isfavorite;
        }
        // Or we can check the list of all favorite courses
        else if (state is FavoriteStateLoaded) {
          isFavorite = state.favoriteCourseId.contains(widget.courseId);
        }

        return GestureDetector(
          onTap: () {
            context.read<FavoriteBloc>().add(
                  ToggleFavoriteEvent(userId, widget.courseId),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_event.dart';
import 'package:growmind/features/home/presentation/bloc/top_tutors_bloc/top_tutors_state.dart';

class TopMentors extends StatelessWidget {
  const TopMentors({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TopTutorsBloc>().add(GetTopTutorsEvent());
    return BlocBuilder<TopTutorsBloc, TopTutorsState>(
        builder: (context, state) {
      if (state is TopTutorLoading) {
        Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TopTutorLoaded) {
        return LimitedBox(
            maxHeight: 50,
            maxWidth: 50,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.tutors.length,
                itemBuilder: (context, index) {
                  final topTutor = state.tutors[index];
                  return Row(
                    children: [
                      const SizedBox(
                        width: 50,
                        height: 50,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(topTutor['imageUrl']),
                      ),
                    ],
                  );
                }));
      }
      return Center(
        child: Text('No value'),
      );
    });
  }
}

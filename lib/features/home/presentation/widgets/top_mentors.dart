
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
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
     const   Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TopTutorLoaded) {
        return LimitedBox(
            maxHeight: 100,
            maxWidth: 300,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.tutors.length,
                itemBuilder: (context, index) {
                  final topTutor = state.tutors[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                         
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration:const BoxDecoration(
                                      color: mainColor,
                                      shape: BoxShape.circle
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration:const BoxDecoration(
                                   shape: BoxShape.circle,
                                      color: textColor
                                    ),
                                    child: ClipOval(child: Image.network(topTutor['imageUrl'],fit: BoxFit.cover,)),
                                  ),
                                ],
                              ),
                               BorderedText(
                                strokeWidth: 5.0,
                                strokeColor: Colors.black,
                                child: Text(topTutor['displayName'],overflow: TextOverflow.ellipsis,style:const TextStyle(fontWeight: FontWeight.w700,color: textColor,fontSize: 15)))
                            ],
                          ),
                        ],
                      ),
                      
                     
                    ],
                  );
                }));
      }
      return const Center(
        child: Text('No value'),
      );
    });
  }
}

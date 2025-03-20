
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/widget/shimmer.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_event.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_state.dart';
import 'package:growmind/features/home/presentation/widgets/cariculumbuilder.dart';


class Curriculum extends StatelessWidget {
  final String courseId;
  final List<SectionEntity> section;
  final String coursePrice;
  const Curriculum(
      {super.key,
      required this.section,
      required this.courseId,
      required this.coursePrice});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    context.read<PurchasedBloc>().add(PurchasedCourseEvent(user!.uid));

    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Curriculum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PurchasedBloc, PurchasedState>(
        builder: (context, purchasedState) {
          if (double.tryParse(coursePrice) != null &&
              double.parse(coursePrice) <= 0) {
            return cariculumbuilder(section);
          }
          if (purchasedState is PurchasedLoaded) {
            final purchasedCourses =
                purchasedState.course; 
            final isPurchased =
                purchasedCourses.any((id) => id.userId == courseId);

            if (!isPurchased) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 100, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "This course is locked.\nPurchase to access the content.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }

          
            return cariculumbuilder(section);
          } else if (purchasedState is PurchasedLoading) {
            return const Center(child: ShimmerLoading());
          } else {
            return const Center(child: Text("Error loading purchases"));
          }
        },
      ),
    );
  }
  


 
}

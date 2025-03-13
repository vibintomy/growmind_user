import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/widget/shimmer.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_event.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_state.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_event.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_state.dart';
import 'package:video_player/video_player.dart';

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
            return cariculumbuilder();
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

          
            return cariculumbuilder();
          } else if (purchasedState is PurchasedLoading) {
            return const Center(child: ShimmerLoading());
          } else {
            return const Center(child: Text("Error loading purchases"));
          }
        },
      ),
    );
  }

  BlocBuilder<CurriculumBloc, CurriculumState> cariculumbuilder() {
    return BlocBuilder<CurriculumBloc, CurriculumState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: section.length,
          itemBuilder: (context, index) {
            final sections = section[index];
            final isExpanded = state.expandedSectionIndex == index;
            return Card(
              color: textColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                              Text('Sections ${index + 1}/${section.length}'),
                        ),
                        Text(
                          ' - ${sections.sectionName}',
                          style: const TextStyle(
                            color: greenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    kheight,
                    ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 239, 237, 237),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}', 
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      title: Text(
                        sections.sectionDescription,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          context.read<CurriculumBloc>().add(
                                ToggleSectionExpansion(
                                    index, sections.videoUrl ?? ''),
                              );
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: state.isLoading &&
                                      state.expandedSectionIndex == index
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Container(
                                        color: greyColor,
                                        child: state.videoPlayerController !=
                                                    null &&
                                                isExpanded
                                            ? VideoPlayer(
                                                state.videoPlayerController!)
                                            : null,
                                      ),
                                    ),
                            ),
                            if (!isExpanded)
                              const Positioned(
                                top: 5,
                                left: 5,
                                right: 5,
                                bottom: 5,
                                child: Icon(
                                  Icons.play_circle,
                                  color: blueColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (isExpanded &&
                        state.videoPlayerController != null &&
                        state.chewieController != null)
                      buildExpansionVideo(state.videoPlayerController!,
                          state.chewieController!),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildExpansionVideo(
      VideoPlayerController controller, ChewieController chewieController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      constraints:
          const BoxConstraints(maxHeight: 300, maxWidth: double.infinity),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 5 / 5,
            child: Chewie(controller: chewieController),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:video_player/video_player.dart';

class Curriculum extends StatelessWidget {
  final List<SectionEntity> section;
  const Curriculum({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: section.length,
          itemBuilder: (context, index) {
            final sections = section[index];

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
                            color: Colors.green,
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
                            '${index + 1}', // Show correct index starting from 1
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      title: Text(
                        sections.sectionDescription,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Stack(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: FutureBuilder<Map<String, dynamic>?>(
                              future: initializeVideo(sections.videoUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Container(
                                    height: 50,
                                    width: 50,
                                    color: greyColor,
                                    child: const Center(
                                      child: Text(
                                        '',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                                final controller = snapshot.data!['controller']
                                    as VideoPlayerController;
                                final duration =
                                    snapshot.data!['duration'] as Duration;
                                final formatedDuration =
                                    formatDuration(duration);

                                return SizedBox(
                                  child: AspectRatio(
                                    aspectRatio: controller.value.aspectRatio,
                                    child: VideoPlayer(controller),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Positioned(
                            top: 5,
                            left: 5,
                            right: 5,
                            bottom: 5,
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.blue,
                            ),
                          ),
                  
                        ],
                      ),
                    ),
                  
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> initializeVideo(String? url) async {
    if (url == null || url.isEmpty) {
      return null; // Return null if no valid URL
    }

    try {
      final controller = VideoPlayerController.network(url);
      await controller.initialize();
      Duration videoDuration = controller.value.duration;
      return {
        "controller": controller,
        "duration": videoDuration,
      };
    } catch (e) {
      print('Error initializing video: $e'); // Debugging output
      return null; // Return null in case of an error
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

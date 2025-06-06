import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/core/widget/shimmer.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_event.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_state.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_event.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_state.dart';
import 'package:growmind/features/chat/presentation/pages/message_page.dart';
import 'package:growmind/features/chat/presentation/widgets/chat_search.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser;
    context.read<MentorBloc>().add(GetMentor(userId: userId!.uid));
    context.read<LastChatBloc>().add(GetLastChatEvent(userId.uid));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Chat',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
              kheight1,
              searchChat(context),
              kheight1,
              Expanded(
                child: BlocBuilder<MentorBloc, MentorState>(
                    builder: (context, state) {
                  if (state is MentorLoading) {
                    return const Center(
                      child: ShimmerLoading(),
                    );
                  }
                  if (state is MentorLoaded) {
                    final tutors = state.tutors;
                    return tutors.isEmpty
                        ? const Center(
                            child: Text('No Chat Found'),
                          )
                        : ListView.builder(
                            itemCount: tutors.length,
                            itemBuilder: (context, index) {
                              final tutor = tutors[index];

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MessagePage(
                                                    imageUrl: tutor.image,
                                                    name: tutor.name,
                                                    receiverId:
                                                        tutors[index].uid,
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        height: 100,
                                        width: 60,
                                        child: ClipOval(
                                            child: Image.network(
                                          tutor.image,
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                      title: Text(
                                        tutor.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17),
                                      ),
                                     subtitle: BlocBuilder<LastChatBloc, LastChatState>(
                                    builder: (context, state) {
                                      if (state is LastChatLoading) {
                                        return const Center(
                                          child: ShimmerLoading(),
                                        );
                                      } else if (state is LastChatLoaded) {
                                        final lastChat = state.lastMessage;
                                        
                                        // Check if the lastChat list has a message for this index
                                        if (lastChat.length > index) {
                                          return Text(
                                            lastChat[index].lastMessage,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          );
                                        } else {
                                          // If there's no message for this tutor, show the default text
                                          return const Text(
                                            'Tap to send message',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          );
                                        }
                                      }
                                      return const Center(
                                        child: Text('Tap to Send Message'),
                                      );
                                    }),
                                    ),
                                  ),
                                  kheight,
                                  const Divider(
                                    height: 1,
                                    color: greyColor,
                                    thickness: 1,
                                  )
                                ],
                              );
                            });
                  }
                  return const Center(
                    child: Text('NO values found'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}

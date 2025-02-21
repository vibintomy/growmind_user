import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_event.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_state.dart';
import 'package:growmind/features/chat/presentation/pages/message_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser;
    context.read<MentorBloc>().add(GetMentor(userId: userId!.uid));
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
                Container(
              height: 50,
              width: 350,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: textColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                        blurRadius: 3,
                        color: greyColor)
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.search,
                          color: textColor,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                
                     
                },
              ),
            ),
              Expanded(
                child: BlocBuilder<MentorBloc, MentorState>(
                    builder: (context, state) {
                  if (state is MentorLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MentorLoaded) {
                    final tutors = state.tutors;
                    return ListView.builder(
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
                                              name: tutor.name)));
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
                                  subtitle: const Text(
                                    'Tap to Send messages',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
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

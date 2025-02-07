import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_event.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profilebloc = context.read<ProfileBloc>();
    profilebloc.add(LoadProfileEvent(user!.uid ?? ""));
    return Scaffold(
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state is ProfileLoaded) {
                        final profile = state.profile;
                        return Text(
                          'Hi,${profile.displayName.toUpperCase()}👋',
                          style: const TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        );
                      }
                      return const Text('');
                    }),
                    Container(
                        height: 50,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 45,
                                width: 95,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.notifications_outlined)),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const Text(
                  'What would like to learn Today?\nSearch Below.',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 112, 110, 110)),
                ),
                kheight1,
              
               Container(height: 50,width: MediaQuery.of(context).size.width,
               decoration:const BoxDecoration(
                color: textColor,
                boxShadow: [BoxShadow(
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                  blurRadius: 3,
                  color: greyColor
                )],
              
                borderRadius: BorderRadius.all(Radius.circular(50))
               ),
               child:Align(
                alignment: Alignment.centerRight,
                child: const Icon(Icons.search)),)
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

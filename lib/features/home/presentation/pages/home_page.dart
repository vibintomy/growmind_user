import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/pages/categories.dart';
import 'package:growmind/features/home/presentation/widgets/custom_paint.dart';
import 'package:growmind/features/home/presentation/widgets/custom_wavy_Shape.dart';
import 'package:growmind/features/home/presentation/widgets/index_indicator.dart';
import 'package:growmind/features/home/presentation/widgets/spinning_container.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_bloc.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_event.dart';
import 'package:growmind/features/profile/presentation/bloc/profile_bloc/bloc/profile_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final CarouselController carouselController = CarouselController();
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
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
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: textColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            spreadRadius: 0,
                            blurRadius: 3,
                            color: greyColor)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.search)),
                ),
                kheight1,
                CarouselSlider.builder(
                  // carouselController: carouselController,
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      currentIndex.value = index;
                    },
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) {
                    Color? containerColor;
                    Widget? topShape;
                    Widget? bottomShape;
                    if (index == 0) {
                      containerColor = Colors.green;
                      topShape = const CustomPaintWidget1();
                      bottomShape = const CustomWavyShape1();
                    } else if (index == 1) {
                      containerColor = Colors.blue;
                      topShape = const CustomPaintWidget2();
                      bottomShape = const CustomWavyShape2();
                    } else {
                      containerColor = const Color(0xFFFEA384);
                      topShape = const CustomPaintWidget();
                      bottomShape = const CustomWavyShape();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  color: greyColor)
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 120,
                                  width: 180,
                                  child: topShape,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                    height: 120,
                                    width: 180,
                                    child: bottomShape),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                kheight,
                indexIndicator(currentIndex: currentIndex),
                kheight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'SEE ALL',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: mainColor),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          size: 14,
                          color: mainColor,
                        )
                      ],
                    ),
                  ],
                ),
                kheight,
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories()));
                    },
                    child: spinningContainer())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/widgets/custom_paint.dart';
import 'package:growmind/features/home/presentation/widgets/custom_wavy_Shape.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
Future<void> completeOnBoarding(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLaunch', false);
  if (context.mounted) {
    Navigator.of(context).pushReplacementNamed('/login');
  } else {
  
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: Image.asset('assets/logo/Group 48.png'),
                ),
              ),
            ),
            kheight,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: Image.asset('assets/logo/Paint.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 150,
                      width: 100,
                      child: Image.asset('assets/logo/paper-plane.png'),
                    ),
                  ),
                ],
              ),
            ),
            kheight1,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: Image.asset('assets/logo/Group 46.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 150,
                      width: 100,
                      child: Image.asset('assets/logo/Books.png'),
                    ),
                  ),
                ],
              ),
            ),
            kheight2,
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          spreadRadius: 3,
                          blurRadius: 3,
                          color: greyColor)
                    ],
                    color: Color.fromARGB(255, 222, 220, 220),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 210,
                        width: 350,
                        decoration: const BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                spreadRadius: 0,
                                blurRadius: 3,
                                color: greyColor)
                          ],
                        ),
                        child:const Stack(
                          children: [
                             Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                height: 120,
                                width: 180,
                                child: CustomPaintWidget1(),
                              ),
                            ),
                            Positioned(
                                left: 20,
                                right: 5,
                                top: 80,
                                bottom: 5,
                                child: Column(
                                  children: [
                                    Text(
                                      'Start Learning',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                          fontSize: 35),
                                    ),
                                     Text(
                                      'Dive into courses designed to expand your skills and knowledge',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 215, 214, 214)),
                                    )
                                  ],
                                )),
                           Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                  height: 120,
                                  width: 180,
                                  child: CustomWavyShape1()),
                            )
                          ],
                        ),
                      ),
                    ),
                         ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                    
                        completeOnBoarding(context);
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: textColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

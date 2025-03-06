import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedWheel extends StatelessWidget {
  final double angle;
   AnimatedWheel({required this.angle, Key? key}) : super(key: key);
  final List<String> images = [
   'assets/logo/design-tools.png',
   'assets/logo/controller.png',
   'assets/logo/personal-development.png',
   'assets/logo/programming.png',
   'assets/logo/stock.png',
   'assets/logo/team.png'
   
  ];


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: angle, 
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
        ...List.generate(6, (index) {
          double iconAngle = (index * 2 * pi) / 6 +
              angle; // Dynamically rotate stars' positions

          return Positioned(
            left: 100 +
                80 * cos(iconAngle) -
                15, 
            top: 100 + 80 * sin(iconAngle) - 15,
            child: Transform.rotate(
              angle: -angle, // Keep stars upright
              child: Container(
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color:  Color.fromARGB(255, 218, 61, 246),
                ),
             
                height: 40,
                width: 40,
                child: Image.asset( images[index]))
            ),
          );
        }),
      ],
    );
  }
}

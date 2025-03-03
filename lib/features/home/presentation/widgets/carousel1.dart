import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growmind/core/utils/constants.dart';


class Carousel1 extends StatelessWidget {
  const Carousel1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [  Text('Enroll into latest courses',style: GoogleFonts.montserrat(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: textColor
        )),
        SizedBox(
          height: 50,
          width: 50,
          child: Image.asset('assets/logo/logo1.png'))
        ],
      ),
    );
  }
}

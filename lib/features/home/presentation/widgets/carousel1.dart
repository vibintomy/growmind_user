import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growmind/core/utils/constants.dart';


class Carousel1 extends StatelessWidget {
  const Carousel1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [  Text('Connect with Mentors',style: GoogleFonts.montserrat(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: textColor
        )),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(child: Image.asset('assets/logo/smiley-teacher-holding-tablet.jpg',fit: BoxFit.cover,))),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipOval(child: Image.asset('assets/logo/man-working-laptop-company.jpg',fit: BoxFit.cover,))),
                ),
              ],
            ),
              SizedBox(
              height: 30,
              width: 30,
              child: ClipOval(child: Image.asset('assets/logo/young-confident-blonde-handsome-man-holds-laptop-isolated-violet-space-with-copy-space.jpg',fit: BoxFit.cover,))),
          ],
        )
        ],
      ),
    );
  }
}

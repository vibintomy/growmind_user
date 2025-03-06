import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growmind/core/utils/constants.dart';

class Carousel2 extends StatelessWidget {
  const Carousel2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          
          Row(
            children: [
              Text('Offers%',
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.w600, color: textColor)),
                       SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipOval(child: Image.asset('assets/logo/16284.jpg',fit: BoxFit.cover,))),
            ],
          ),
          const  Text('Get special Exclusive offers for every courses',style: TextStyle(color: textColor,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growmind/core/utils/constants.dart';

class Carousel3 extends StatelessWidget {
  const Carousel3({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      child: Column(
        
        children: [ 
          kheight,
                 SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(child: Image.asset('assets/logo/controller.png',fit: BoxFit.cover,))),
           Text('Grab your ❤️ courses',style: GoogleFonts.montserrat(
                     fontSize: 25,
                     fontWeight: FontWeight.w600,
                     color: textColor
                   )),
           Align(
            alignment: Alignment.centerLeft,
             child: SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipOval(child: Image.asset('assets/logo/team.png',fit: BoxFit.cover,))),
           ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: textColor,
      
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
      ),
    body: SingleChildScrollView( 
       
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
             Container(
              height: 250,
              width: 150,
              decoration :const BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor
              ),
             ),
              Container(
              height: 170,
              width: 135,
              decoration :const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
              ),
             )
              ],
            ),
          )
        ],
      ),
    ),
    
    );
  }
}
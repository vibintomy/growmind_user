
  import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';

Stack displayImage(BuildContext context,String imageUrl) {
    return Stack(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back,color: textColor,),
                  ),
                )),
                
          ],
        );
  }
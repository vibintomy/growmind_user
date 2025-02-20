
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';


class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index,required this.url,required this.courseName});
  final int index;
  final String url;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 170,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:  DecorationImage(
                    fit: BoxFit.cover,
                    image:url.isNotEmpty? NetworkImage(
                     url ): AssetImage('')),
              ),
            ),
          ],
        ),
        Positioned(
            left: 13,
            bottom: -30,
            child: BorderedText(
                strokeWidth: 10.0,
                strokeColor: mainColor,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                      fontSize: 100,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.black),
                ))),
                kwidth,
                 Positioned(
                right: 10,
            bottom: 10,
            child: BorderedText(
                strokeWidth: 10.0,
                strokeColor: Colors.black,
                child: Text(
                 courseName,overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.black),
                ))),
      ],
    );
  }
}


  import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


ValueListenableBuilder<int> indexIndicator({required  currentIndex}) {
     
    return ValueListenableBuilder(
                  valueListenable: currentIndex,
                  builder: (context, value, child) {
                    return  Center(
                      child:AnimatedSmoothIndicator(
                        activeIndex: value,
                         count: 3,
                         effect:const ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: Color.fromARGB(255, 10, 117, 205),
                          dotColor: mainColor
                         ),
                         ),
                    );
                  });
  }
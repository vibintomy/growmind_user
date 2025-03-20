
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/widgets/carousel1.dart';
import 'package:growmind/features/home/presentation/widgets/carousel2.dart';
import 'package:growmind/features/home/presentation/widgets/carousel3.dart';
import 'package:growmind/features/home/presentation/widgets/custom_paint.dart';
import 'package:growmind/features/home/presentation/widgets/custom_wavy_Shape.dart';

CarouselSlider carouselWidget(ValueNotifier currentIndex) {
    return CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  },
                ),
                itemCount: 3,
                itemBuilder: (context, index, realIndex) {
                  Color? containerColor;
                  Widget? topShape;
                  Widget? bottomShape;
                  Widget? centerData;
                  if (index == 0) {
                    containerColor = Colors.green;
                    topShape = const CustomPaintWidget1();
                    bottomShape = const CustomWavyShape1();
                    centerData = const Carousel1();
                  } else if (index == 1) {
                    containerColor = Colors.blue;
                    topShape = const CustomPaintWidget2();
                    bottomShape = const CustomWavyShape2();
                    centerData = const Carousel3();
                  } else {
                    containerColor = const Color(0xFFFEA384);
                    topShape = const CustomPaintWidget();
                    bottomShape = const CustomWavyShape();
                    centerData = const Carousel2();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 3),
                                spreadRadius: 0,
                                blurRadius: 3,
                                color: greyColor)
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                height: 120,
                                width: 180,
                                child: topShape,
                              ),
                            ),
                            Positioned(
                                left: 30,
                                right: 5,
                                top: 80,
                                bottom: 5,
                                child: centerData),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                  height: 120,
                                  width: 180,
                                  child: bottomShape),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
  }
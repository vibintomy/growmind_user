
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/bloc/animation_bloc.dart';
import 'package:growmind/features/home/presentation/widgets/animated_container_widget.dart';

Container spinningContainer() {
    return Container(
                height: 150,
                width: 400,
               decoration:const BoxDecoration(
                color: Color(0xFF8A2BE2),
                borderRadius: BorderRadius.all(Radius.circular(30),),
                boxShadow: [BoxShadow(
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                  blurRadius: 3,
                  color: greyColor
                )]
               ),
                child: Column(
                  children: [
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      kwidth,
                        Column(
                          children: [
                  const          Text('Categories',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: textColor),),
                                Container(
                                  width: 60,
                                  height: 20,
                                  color: textColor,
                                child:const Center(child: Text('View All',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13,  color: Color(0xFF8A2BE2)),))),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 150,
                                width: 130,color: Colors.transparent,
                                child: BlocBuilder<AnimationCubit, double>(
                                  builder: (context, angle) {
                                
                                return AnimatedWheel(angle: angle);
                                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
  }
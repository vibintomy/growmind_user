 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_bloc.dart';
import 'package:growmind/features/chat/presentation/bloc/mentor_bloc/mentor_event.dart';

Container searchChat(BuildContext context) {
    return Container(
              height: 50,
              width: 350,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: textColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                        blurRadius: 3,
                        color: greyColor)
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(
                          right: 10, top: 10, bottom: 10),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.search,
                          color: textColor,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  context.read<MentorBloc>().add(SearchMentor(value));
                },
              ),
            );
  }
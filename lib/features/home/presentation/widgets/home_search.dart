 import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/pages/search_page.dart';

Container homeSearch(BuildContext context) {
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
                  readOnly: true,
                  showCursor: false,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, top: 10, bottom: 10),
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColor,
                          ),
                          child: const Icon(
                            Icons.search,
                            color: textColor,
                          ),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const SearchPage()));
                  },
                ),
              );
  }
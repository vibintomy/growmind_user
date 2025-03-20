// search_widget.dart
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';

class SearchWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color shadowColor;
  final Color iconBackgroundColor;
  final Color iconColor;

  const SearchWidget({
    Key? key,
    this.onChanged,
    this.hintText = 'Search',
    this.height = 50,
    this.width = 350,
    this.backgroundColor = textColor,
    this.shadowColor = greyColor,
    this.iconBackgroundColor = textColor1,
    this.iconColor = textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 3,
            color: shadowColor,
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Icon(
                Icons.search,
                color: iconColor,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
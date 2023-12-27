// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';



class OnboardingPageModel {
  final String title;
  final String description;
  final Image image;
  final Gradient bgColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    Gradient? bgColor,
    Color textColor = Colors.black,
    this.titleStyle = const TextStyle(
    fontSize: 24, color:Color(0xFF272665) , fontFamily: 'Quicksand',fontWeight: FontWeight.w600
    ),
    this.descriptionStyle = const TextStyle(
      fontSize: 16,color:Color(0xFF707070),fontFamily: 'Quicksand',fontWeight: FontWeight.w400
    ),
  }) : bgColor = bgColor ??
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.71, 0.75, 1.0,  1.0],
              colors: [
                Color(0xFFEEEDF5),
                Color(0xFFF0EFF6),
                
                Color(0xFFFEFEFE),
                Color(0xFFFFFFFF),
              ],
            );
}

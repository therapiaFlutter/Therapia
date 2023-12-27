// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';


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
      fontSize: 24, color: Color(0xFF272665), fontFamily: 'Quicksand', fontWeight: FontWeight.w600,
    ),
    this.descriptionStyle = const TextStyle(
      fontSize: 16, color: Color(0xFF707070), fontFamily: 'Quicksand', fontWeight: FontWeight.w400,
    ),
  }) : bgColor = bgColor ?? PageBackground.getBackgroundColor();
}
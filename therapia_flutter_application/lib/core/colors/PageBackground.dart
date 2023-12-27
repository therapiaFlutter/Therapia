// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

class PageBackground {
  static LinearGradient getBackgroundColor() {
    return LinearGradient(
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
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppointmentCustomBtn extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;

  const AppointmentCustomBtn({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          color: Color(0xff6200ee),
          borderRadius: BorderRadius.circular(13),
        ),
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

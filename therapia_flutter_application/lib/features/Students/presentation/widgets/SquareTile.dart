import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF734BFB)),
        borderRadius: BorderRadius.circular(26),
         color: Color(0xFFF5F5F5),
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
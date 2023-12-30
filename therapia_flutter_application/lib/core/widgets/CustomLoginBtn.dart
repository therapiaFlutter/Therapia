// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButtonStyle extends StatelessWidget {
 final Function()? onTap;
 final String btnText;

 const CustomButtonStyle({Key? key, required this.onTap, required this.btnText}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onTap,
     child: Container(
       
       margin: const EdgeInsets.symmetric(horizontal: 35),
       decoration: BoxDecoration(
         color: Color(0xFF734afb),
         borderRadius: BorderRadius.circular(48),
         
       ),
       height: 65,
       width: 300,
       child: Center(
         child: Text(
           btnText,
           style: TextStyle(
             color: Color(0xFFF0EFF6),
             fontFamily: 'Quicksand', fontWeight: FontWeight.w600,
             fontSize: 22,
             letterSpacing: 1,
           ),
         ),
       ),
     ),
   );
 }
}

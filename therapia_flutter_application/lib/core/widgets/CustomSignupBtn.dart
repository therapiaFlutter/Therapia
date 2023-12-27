// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomSignupBtn extends StatelessWidget {
 final Function()? onTap;
 final String btnText;

 const CustomSignupBtn({Key? key, required this.onTap, required this.btnText}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onTap,
     child: Container(
       
       margin: const EdgeInsets.symmetric(horizontal: 35),
       decoration: BoxDecoration(
         color: Color(0xFFF0EFF6),
         borderRadius: BorderRadius.circular(48),
        border: Border.all(color: Color(0xFF734BFB))
         
       ),
       height: 70,
       width: 300,
       child: Center(
         child: Text(
           btnText,
           style: TextStyle(
             color: Color(0xFF734BFB),
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

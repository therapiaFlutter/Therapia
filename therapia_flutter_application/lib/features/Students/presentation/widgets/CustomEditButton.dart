// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomEditButton extends StatelessWidget {
 final Function()? onTap;
 final String btnText;

 const CustomEditButton({Key? key, required this.onTap, required this.btnText}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onTap,
     child: Container(
       
       margin: const EdgeInsets.symmetric(horizontal: 15),
       decoration: BoxDecoration(
         color: Color(0xFFF5F5F5),
         borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Color(0xFF734BFB))
         
       ),
       height: 35,
       width: 150,
       child: Center(
         child: Text(
           btnText,
           style: TextStyle(
             color: Color(0xFF734BFB),
             fontFamily: 'Quicksand', fontWeight: FontWeight.w600,
             fontSize: 18,
             letterSpacing: 1,
           ),
         ),
       ),
     ),
   );
 }
}

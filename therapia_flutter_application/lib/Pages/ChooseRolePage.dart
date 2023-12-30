// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/SignupPsy.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/SignupPage.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: PageBackground.getBackgroundColor(),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                      ),
                      Image.asset(
                        "lib/core/assets/images/therpeia_logo.png",
                        width: 200,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Begin Your Path to Well-being Here",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      CustomButtonStyle(
                        onTap: () {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(Signup()));
                        },
                        btnText: "Student",
                      ),
                      SizedBox(
                        height:40,
                      ),
                      Text(
                        "Be Part of a Supportive Community",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      CustomButtonStyle(
                        onTap: () {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(SignupPsy()));
                        },
                        btnText: "Psychotherapist",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 20,
                  child: SvgPicture.asset(
                    "lib/core/assets/images/shape.svg",
                    width: 200,
                  ),
                ),
                Positioned(
                  right: -18,
                  bottom: 0,
                  child: SvgPicture.asset(
                    "lib/core/assets/images/shape.svg",
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

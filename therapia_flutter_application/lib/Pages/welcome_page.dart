// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/core/widgets/CustomSignupBtn.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/LoginPage.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/SignupPage.dart';



class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
                        height: 190,
                      ),
                      Image.asset(
                        "lib/core/assets/images/therpeia_logo.png",
                        width: 250,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Get Started",
                        style: TextStyle(
                          fontSize: 21,
                          fontFamily: 'Quicksand', fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                      ),
                      CustomButtonStyle(
                        onTap: () {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(LoginPage()));
                        },
                        btnText: "Login",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                        CustomSignupBtn(
                        onTap: () {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(Signup()));
                        },
                        btnText: "Signup",
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 20,
                  child: SvgPicture.asset(
                    "lib/core/assets/images/decoration.svg",
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 20,
                  child: SvgPicture.asset(
                    "lib/core/assets/images/decoration.svg",
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

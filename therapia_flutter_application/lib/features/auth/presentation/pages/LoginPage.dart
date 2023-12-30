// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/Pages/Testpsy.dart';
import 'package:therapia_flutter_application/core/widgets/BottomNavBar.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/CustomTextField.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/SquareTile.dart';
import 'package:therapia_flutter_application/features/auth/domain/entities/user_entity.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/SignupPage.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/intro_screens.dart';
import 'package:therapia_flutter_application/features/psychotherapist/presentation/pages/PsyIntroScreens.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: Container(
        decoration: BoxDecoration(
          gradient: PageBackground.getBackgroundColor(),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/core/assets/images/therpeia_logo.png",
                      width: 150,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Welcome Back !',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: usernameController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButtonStyle(
                      onTap: () {
                        signIn(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                          context,
                        );
                      },
                      btnText: 'Login',
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                            imagePath: 'lib/core/assets/images/google.png'),
                        SizedBox(width: 25),
                        SquareTile(
                            imagePath: 'lib/core/assets/images/facebook.png')
                      ],
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signup()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Register now',
                            style: TextStyle(
                              color: Color(0xFF734BFB),
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      route(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "psy") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PsyIntroScreens(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => IntroScreens(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}

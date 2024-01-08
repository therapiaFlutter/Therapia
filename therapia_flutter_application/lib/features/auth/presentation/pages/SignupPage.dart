// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/CustomTextField.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/SquareTile.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/LoginPage.dart';
import 'package:therapia_flutter_application/core/exceptions/FormValidation.dart';
import 'package:therapia_flutter_application/core/widgets/CustomToast.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';

class Signup extends StatelessWidget {
  Signup({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _registerUser(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoadingAnimation();
        },
      );

      if (_formKey.currentState?.validate() ?? false) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((value) {
          Navigator.of(context, rootNavigator: true).pop();

          postDetailsToFirestore(emailController.text, 'student');

          CustomToast.show(context, 'Account created successfully', isSuccess: true);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }).catchError((e) {
          Navigator.of(context, rootNavigator: true).pop();

          CustomToast.show(context, 'Error during registration: $e', isSuccess: false);
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      CustomToast.show(context, 'Error during registration: ${e.message}', isSuccess: false);
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref.doc(user!.uid).set({'email': email, 'role': role});
  }

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
            child: Form(
              key: _formKey,
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
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        validator: FormValidation.emailValidator,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          FormValidation.emailValidator(emailController.text) ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: FormValidation.passwordValidator,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          FormValidation.passwordValidator(passwordController.text) ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButtonStyle(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            _registerUser(context);
                          }
                        },
                        btnText: 'Create Account',
                      ),
                      const SizedBox(height: 30),
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
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(imagePath: 'lib/core/assets/images/google.png'),
                          SizedBox(width: 25),
                          SquareTile(imagePath: 'lib/core/assets/images/facebook.png')
                        ],
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Already have an account ?",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Login',
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
      ),
    );
  }
}

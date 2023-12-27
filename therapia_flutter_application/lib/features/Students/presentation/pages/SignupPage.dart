// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/HomePage.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/CustomTextField.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/SquareTile.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/LoginPage.dart';
import 'package:therapia_flutter_application/core/exceptions/FormValidation.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';

class Signup extends StatelessWidget {
  Signup({Key? key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      // username textfield
                      CustomTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      // email textfield
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        validator: FormValidation.emailValidator,
                      ),
                      const SizedBox(height: 10),
                      // password textfield
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: FormValidation.passwordValidator,
                      ),
                      const SizedBox(height: 30),

                      // sign-in button
                      CustomButtonStyle(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                          }
                            
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(HomePage()));
                      

                        },
                        btnText: 'Create Account',
                      ),

                      const SizedBox(height: 30),
                      // or continue with
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
                      const SizedBox(height: 30),
                      // Google and Facebook buttons
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
                      // Register now link
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
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

// signup.dart
import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/CustomLoginBtn.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/CustomTextField.dart';
import 'package:therapia_flutter_application/features/Students/presentation/widgets/SquareTile.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/features/auth/data/repositories/FirestoreRepository.dart';
import 'package:therapia_flutter_application/features/auth/domain/repositories/AuthRepository.dart';
import 'package:therapia_flutter_application/features/auth/domain/usecases/SignupUseCase.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/SignupPresenter.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/LoginPage.dart';
import 'package:therapia_flutter_application/core/exceptions/FormValidation.dart';


class Signup extends StatelessWidget {
  Signup({Key? key}) : _presenter = SignupPresenter(SignupUseCase(AuthRepository(), FirestoreRepository()));

  final SignupPresenter _presenter;

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
              key: _presenter.formKey,
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
                        controller: _presenter.usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _presenter.emailController,
                        hintText: 'Email',
                        obscureText: false,
                        validator: FormValidation.emailValidator,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          FormValidation.emailValidator(_presenter.emailController.text) ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _presenter.passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: FormValidation.passwordValidator,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          FormValidation.passwordValidator(_presenter.passwordController.text) ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButtonStyle(
                        onTap: () {
                          if (_presenter.formKey.currentState?.validate() ?? false) {
                            _presenter.formKey.currentState?.save();
                            _presenter.registerUser(context);
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

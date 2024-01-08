import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/CustomToast.dart';
import 'package:therapia_flutter_application/core/widgets/LoadingAnimation.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';
import 'package:therapia_flutter_application/features/auth/domain/usecases/SignupUseCase.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/LoginPage.dart';


class SignupPresenter {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignupUseCase signupUseCase;

  SignupPresenter(this.signupUseCase);

  Future<void> registerUser(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoadingAnimation();
        },
      );

      if (formKey.currentState?.validate() ?? false) {
        await signupUseCase.execute(
          email: emailController.text,
          password: passwordController.text,
          onSuccess: (user) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomToast.show(context, 'Account created successfully', isSuccess: true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          onError: (e) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomToast.show(context, 'Error during registration: $e', isSuccess: false);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      CustomToast.show(context, 'Error during registration: ${e.message}', isSuccess: false);
    }
  }
}
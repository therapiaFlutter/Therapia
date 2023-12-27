import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/Pages/intro_screens.dart';
import 'package:therapia_flutter_application/Pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/", routes: {
      "/": (context) => const IntroScreens(),
      "/welcome": (context) => const Welcome(),
    });
  }
}
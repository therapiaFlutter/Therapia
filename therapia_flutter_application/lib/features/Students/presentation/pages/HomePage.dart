import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/BottomNavBar.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: GoogleBottomBar(), // Use GoogleBottomBar as the home widget
    );
  }
}
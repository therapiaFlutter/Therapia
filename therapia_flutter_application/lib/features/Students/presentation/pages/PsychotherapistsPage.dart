import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/BottomNavBar.dart';

void main() => runApp(const PsychotherapistsPage());

class PsychotherapistsPage extends StatelessWidget {
  const PsychotherapistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: GoogleBottomBar(), // Use GoogleBottomBar as the home widget
    );
  }
}
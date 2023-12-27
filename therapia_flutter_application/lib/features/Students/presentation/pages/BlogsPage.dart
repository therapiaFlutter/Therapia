import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/widgets/BottomNavBar.dart';

void main() => runApp(const BlogsPage());

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: GoogleBottomBar(), // Use GoogleBottomBar as the home widget
    );
  }
}
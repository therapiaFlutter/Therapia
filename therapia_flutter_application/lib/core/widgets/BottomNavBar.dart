// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/HomePage.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/SettingsPage.dart';
import 'package:therapia_flutter_application/features/psychotherapist/presentation/pages/PsychotherapistsPage.dart';
import 'package:therapia_flutter_application/features/Blogs/presentation/pages/BlogsPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GoogleBottomBar(),
    );
  }
}

class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({Key? key}) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BlogsPage(),
    PsychotherapistsPage(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text(
      "Home",
      style: TextStyle(
           fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
    ),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.feed),
    title: const Text(
      "Blogs",
      style: TextStyle(
           fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
    ),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text(
      "Psychotherapists",
      style: TextStyle(
           fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
    ),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text(
      "Settings",
      style: TextStyle(
           fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
    ),
    selectedColor: Color(0xFF734BFB),
  ),
];

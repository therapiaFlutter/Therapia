import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/HomePage.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/AppointmentsPage.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/BlogsPage.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/PsychotherapistsPage.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
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
    AppointmentsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF734BFB),
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
    title: const Text("Home"),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.feed),
    title: const Text("Blogs"),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Psychotherapists"),
    selectedColor: Color(0xFF734BFB),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.calendar_today),
    title: const Text("Appointments"),
    selectedColor: Color(0xFF734BFB),
  ),
];

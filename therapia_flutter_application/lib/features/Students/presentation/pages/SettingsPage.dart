// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/Profile.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/appointments.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/auth/auth_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: PageBackground.getBackgroundColor(),
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: const [
                  _CustomListTile(
                    title: "Notifications",
                    icon: Icons.notifications_none_rounded,
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                title: "Organization",
                children: [
                  _CustomListTile(
                    title: "Profile",
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "My Appointments",
                    icon: Icons.calendar_today_rounded,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Appointment(),
                      ));
                    },
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                children: [
                  _CustomListTile(
                    title: "Help & Feedback",
                    icon: Icons.help_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Sign out",
                    icon: Icons.exit_to_app_rounded,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                
                BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                GoRouter.of(context).go('/login');

                Navigator.pop(context); 
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Icon(icon),
      onTap: onTap != null
          ? () {
              if (onTap != null) {
                onTap!();
              }
            }
          : null,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 17,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w800,
                color: Color(0xFF734BFB),
              ),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}

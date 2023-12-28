// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';

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
              children: [
                const _CustomListTile(
                  title: "Notifications",
                  icon: Icons.notifications_none_rounded,
                ),
              ],
            ),
            const Divider(),
            const _SingleSection(
              title: "Organization",
              children: [
                _CustomListTile(
                  title: "Profile",
                  icon: Icons.person_outline_rounded,
                ),
                _CustomListTile(
                  title: "My Appointments",
                  icon: Icons.calendar_today_rounded,
                ),
              ],
            ),
            const Divider(),
            const _SingleSection(
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
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
 }
}

class _CustomListTile extends StatelessWidget {
 final String title;
 final IconData icon;
 final Widget? trailing;
 const _CustomListTile({
  Key? key,
  required this.title,
  required this.icon,
  this.trailing,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        
      ),
    ),
    leading: Icon(icon),
    trailing: trailing,
    onTap: () {},
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
              color: Color(0xFF734BFB)
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

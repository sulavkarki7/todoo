import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todoo/constants/constants.dart';
import 'package:todoo/pages/my_profile_page.dart';

class ListtileForProfile extends StatelessWidget {
  ListtileForProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.ownpage,
  });

  final String title;
  final IconData icon;
  final Widget ownpage;

  static List<ListtileForProfile> getlist() {
    return [
      ListtileForProfile(
        title: "My Profile",
        icon: Icons.account_circle_outlined,
        ownpage: const MyProfilePage(),
      ),

      // ListtileForProfile(
      //   title: "Settings",
      //   icon: Icons.settings_outlined,
      //   ownpage: const SettingsPage(),
      // ),
      // ListtileForProfile(
      //   title: "Help Center",
      //   icon: Icons.help_center_outlined,
      //   ownpage: const HelpCenterPage(),
      // ),

      // ListtileForProfile(
      //   title: "Syllabus",
      //   icon: Icons.menu_book_outlined,
      //   ownpage: const SyllabusPage(),
      // ),

      // ListtileForProfile(
      //   title: "Log Out",
      //   icon: Icons.logout_rounded,
      //   ownpage: const LogOutPage(),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            log('ListtileForProfile: $title have been pressed');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ownpage;
            }));
          },
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black54,
              size: 32,
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined,
                color: Colors.black54),
            title: Text(
              title,
              style: subtitleStyle,
            ),
          ),
        ),
        Divider(
          color: Colors.grey[400],
          indent: 20,
          endIndent: 20,
          height: 0,
        ),
      ],
    );
  }
}

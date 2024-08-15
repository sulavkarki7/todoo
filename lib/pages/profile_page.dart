import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todoo/models/listtile_for_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ListtileForProfile> liist = ListtileForProfile.getlist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              size: 20, color: Colors.black), // Your custom icon
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.045),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black45,
                  radius: 70.00,
                  backgroundImage: AssetImage("images/first.png"),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  top: 100,
                  left: 95,
                  child: Container(
                    // height: 5,
                    // width: 55,
                    decoration: BoxDecoration(
                        // color: const Color(0xFF2B3C98),
                        color: Colors.yellow.shade600,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ProfileeditPage(),
                        //   ),
                        // );
                      },
                      icon: const Icon(
                        size: 20,
                        Icons.border_color,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              'Sulav',
            ),
            ListView.builder(
              itemCount: liist.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => liist[index],
            ),
          ],
        ),
      ),
    );
  }
}

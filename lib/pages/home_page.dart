import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:todoo/constants/constants.dart';
import 'package:todoo/models/task_list.dart';
import 'package:todoo/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.yellow,
        backgroundColor: Colors.yellow,
        leading: const Icon(Icons.menu),
      ),
      body: Stack(children: [
        Container(
          height: Get.height * 0.43,
          decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          'Hello Ender',
                          style: titleStyle,
                        ),
                        const Text(
                          'Today you have 4 tasks',
                          // style: subtitleStyle,
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        log('Profile ma gayo');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                      },
                      icon: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/first.png')),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 100),
          child: TaskList(),
        )
      ]),
    );
  }
}

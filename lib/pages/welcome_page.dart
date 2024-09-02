import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todoo/constants/constants.dart';
import 'package:todoo/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/first.png', height: Get.height * 0.3),
          SizedBox(height: Get.height * 0.05),
          Text(
            'Get Organized Your Life',
            style: titleStyle,
          ),
          SizedBox(height: Get.height * 0.02),
          Center(
            child: Container(
              width: Get.width * 0.7,
              child: Text(
                textAlign: TextAlign.center,
                maxLines: 3,
                'Tudy is a simple and effective \ntodo list and task manager app \nwhich helps you manage time.',
                style: subtitleStyle,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade300,
            ),
            width: Get.width * 0.7,
            height: Get.height * 0.06,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Learn More'),
                  content: Text(
                      'Tudy is designed to help you organize your tasks efficiently. Manage your time, set priorities, and achieve your goals.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Learn More',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

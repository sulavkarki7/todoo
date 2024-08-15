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
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/first.png'),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Text(
            'Get Organized Your Life',
            style: titleStyle,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
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
          SizedBox(
            height: Get.height * 0.05,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade300,
            ),
            width: Get.width * 0.7,
            height: Get.height * 0.06,
            // color: Colors.green.shade300,
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}

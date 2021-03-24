import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/widgets/background.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(),
          Image.asset(
            'assets/owl.png',
            height: Get.size.height / 3,
          ),
        ],
      ),
    );
  }
}

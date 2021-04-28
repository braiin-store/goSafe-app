import 'package:get/get.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/src/widgets/forms.dart';
import 'package:app/src/widgets/background.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentIndex = 0;
  int getIndex() => currentIndex;

  Widget get body {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, top: Get.height / 7),
          child: Image.asset('assets/owl.png', height: Get.height / 4),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CupertinoTabBar.CupertinoTabBar(
            Get.theme.primaryColor,
            Color(0xffEEEEEE),
            [
              Text(
                "Existente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentIndex == 1 ? Colors.white : null,
                ),
              ),
              Text(
                "Nuevo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentIndex == 0 ? Colors.white : null,
                ),
              ),
            ],
            getIndex,
            (index) => setState(() => currentIndex = index),
            useShadow: false,
            allowExpand: true,
            useSeparators: true,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        currentIndex == 0 ? SignInForm() : SignUpForm(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Background(div: 6.5, drawUpDown: false),
          SingleChildScrollView(
            child: body,
            padding: EdgeInsets.only(bottom: Get.height / 5),
          ),
        ],
      ),
    );
  }
}

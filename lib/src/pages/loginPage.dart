import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;

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
    final size = MediaQuery.of(context).size;
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20, top: size.height / 7),
          child: Image.asset('assets/owl.png', height: size.height / 4),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CupertinoTabBar.CupertinoTabBar(
            Color(0xff91bF19),
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
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: currentIndex == 0 ? SignInForm() : SignUpForm(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: MaterialButton(
            color: Color(0xff222222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              currentIndex == 0 ? 'Iniciar Sesión' : 'Registrarse',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => print('HI!!'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(div: 6.5, drawUpDown: false),
          body,
        ],
      ),
    );
  }
}
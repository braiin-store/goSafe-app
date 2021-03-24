import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:app/src/pages/homePage.dart';
import 'package:app/src/pages/loginPage.dart';
import 'package:app/src/pages/enterPhonePage.dart';
import 'package:app/src/pages/confirmPhonePage.dart';
import 'package:app/src/pages/finishRegisterPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Color(0xff80AF08),

        buttonColor: Color(0xff222222),
        accentColor: Color(0xffD1D5DB),

        primaryColor: Color(0xff80AF08),
        primaryColorDark: Color(0xff222222),

        backgroundColor: Color(0xffD1D5DB),
        scaffoldBackgroundColor: Colors.white,

        iconTheme: IconThemeData(size: 27, color: Color(0xff222222)),
        textTheme: TextTheme(
          button: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          
          bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          
          headline3: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          headline5: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.black),
          headline6: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff80AF08)),
        ),
      ),
      initialRoute: 'login',      
      getPages: [
        GetPage(name: 'home',     page: () => HomePage(), transition: Transition.rightToLeftWithFade, transitionDuration: Duration(milliseconds: 400)),
        GetPage(name: 'login',    page: () => LoginPage(), transition: Transition.upToDown, transitionDuration: Duration(seconds: 1)),
        GetPage(name: 'phone',    page: () => EnterPhonePage(), transition: Transition.cupertino, transitionDuration: Duration(milliseconds: 500)),
        GetPage(name: 'confirm',  page: () => ConfirmPhonePage()),
        GetPage(name: 'finish',   page: () => FinishRegisterPage()),
      ],
    );
  }
}

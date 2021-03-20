import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:app/src/pages/homePage.dart';
import 'package:app/src/pages/signInPage.dart';

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
        ),
      ),
      initialRoute: 'signIn',
      getPages: [
        GetPage(name: 'home', page: () => HomePage()),
        GetPage(name: 'signIn', page: () => SignInPage()),
      ],
    );
  }
}

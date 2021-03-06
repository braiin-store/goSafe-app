import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:app/src/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.grey[100],
        
        buttonColor: Color(0xff222222),
        accentColor: Color(0xffD1D5DB),

        primaryColor: Color(0xff80AF08),
        primaryColorDark: Color(0xff222222),

        backgroundColor: Color(0xffD1D5DB),
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff80AF08),
          iconTheme: IconThemeData(size: 30, color: Colors.white),
          titleTextStyle: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
          textTheme: TextTheme(
            subtitle1: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),

        iconTheme: IconThemeData(size: 27, color: Color(0xff222222)),

        textTheme: TextTheme(
          button: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          
          subtitle1: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
          subtitle2: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),
          
          bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
          
          caption: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey),

          headline2: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          headline3: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
          headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          headline5: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.black),
          headline6: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff80AF08)),

          overline: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff80AF08)),
        ),
      ),
      
      getPages: pages,
      initialRoute: Routes.home.toString(),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

const version = 'Versión 1.0.0';
const info = "Desarrollado & Diseñado";
const address = '135 Moldes, Santa Cruz de la Sierra';
const members = [
  "Mauricio Valderrama",
  "Pablo Tardío Ventura",
  "Pedro Caricari Torrejón",
];

const logoBrainstore =
    "https://firebasestorage.googleapis.com/v0/b/gosafe-d4fd9.appspot.com/o/assets%2FlogoBS.png?alt=media&token=6d374a0b-6669-4324-9060-35bf40eb4781";

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de', style: Get.theme.appBarTheme.titleTextStyle),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 50),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Text('GO',
                              style: TextStyle(
                                fontSize: 50,
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.w900,
                              )),
                        ),
                        WidgetSpan(
                          child: Text('SAFE',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    version,
                    style: Get.theme.appBarTheme.textTheme.subtitle1,
                  ),
                ),
                Container(height: 2, color: Colors.grey),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    info,
                    style: Get.theme.appBarTheme.textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: logoBrainstore,
                      height: Get.height / 3,
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(milliseconds: 500),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'BrainStore Inc',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.grey, size: 50),
                      Column(
                        children: members.map((name) {
                          return Text(
                            name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }).toList(),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                Text('Santa Cruz - Bolivia', style: Get.textTheme.caption),
                Text(address, style: Get.textTheme.caption),
                Text('Derechos Reservados ©℗®™', style: Get.textTheme.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

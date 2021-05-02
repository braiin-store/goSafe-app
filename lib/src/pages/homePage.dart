import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/widgets/map.dart';
import 'package:app/src/widgets/drawer.dart';
import 'package:app/src/widgets/bottomSheet.dart';

import 'package:app/src/services/getMap.dart';
import 'package:app/src/services/getTravel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(GetTravelController());
  final mapController = Get.put(GetMapController());

  bool showMarker = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          MapView(),
          Positioned(
            top: 25,
            left: 20,
            child: cornerButton(iconData: Icons.menu),
          ),
          Positioned(
            top: 25,
            right: 20,
            child: cornerButton(
              tag: 'alert',
              iconData: Icons.taxi_alert,
              onPressed: () async {
                await Get.defaultDialog<void>(
                  title: 'Está en Peligro?',
                  titleStyle: Get.textTheme.overline,
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Por Favor Mantenga presionado  Si!!',
                      style: Get.textTheme.headline6,
                    ),
                  ),
                  confirm: MaterialButton(
                    child: Text(
                      'Si!!',
                      strutStyle:
                          StrutStyle.fromTextStyle(Get.textTheme.button),
                      style: TextStyle(color: Get.theme.primaryColor),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side:
                          BorderSide(width: 1.5, color: Get.theme.primaryColor),
                    ),
                    onPressed: () {
                      // TODO share localization to server
                      print('EMIT LOCATION');
                      Get.back();
                    },
                  ),
                  cancel: MaterialButton(
                    child: Text(
                      'NO',
                      strutStyle:
                          StrutStyle.fromTextStyle(Get.textTheme.button),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.5, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () => Get.back(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 45,
            child: cornerButton(
              tag: 'location',
              iconData: Icons.location_searching,
              onPressed: () async => await mapController.getLocationCamera(),
            ),
          ),
          RequestBottomSheet(),
        ],
      ),
    );
  }

  Widget cornerButton({String tag, IconData iconData, Function onPressed}) {
    return FloatingActionButton(
      heroTag: tag ?? 'drawer',
      child: Icon(iconData, color: Get.theme.primaryColor),
      backgroundColor: Colors.white,
      onPressed: onPressed ?? () => _scaffoldKey.currentState.openDrawer(),
    );
  }
}

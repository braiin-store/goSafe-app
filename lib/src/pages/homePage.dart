import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/widgets/map.dart';
import 'package:app/src/widgets/drawer.dart';
import 'package:app/src/widgets/bottomSheet.dart';

import 'package:app/src/services/getTravel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(GetTravelController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.clear();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(child: MapView()),

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
              onPressed: () => print('ALERT'),
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
      child: Icon(iconData, color: Color(0xff80AF08)),
      backgroundColor: Colors.white,
      onPressed: onPressed ?? () => _scaffoldKey.currentState.openDrawer(),
    );
  }
}

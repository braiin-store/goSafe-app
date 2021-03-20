import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/pages/Map/inputLocation.dart';

class SearchRoute extends StatefulWidget {
  SearchRoute({Key key}) : super(key: key);

  @override
  _SearchRouteState createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  String search;
  LatLng source, destiny;

  Widget searchList() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InputLocation(
            hintText: 'Punto de Partida',
            iconData: Icons.location_on_sharp,
          ),
          InputLocation(
            hintText: 'Punto de Llegada',
            iconData: Icons.flag_rounded,
          ),
        ],
      ),
    );
  }
}

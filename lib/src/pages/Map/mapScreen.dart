import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:app/src/widgets/map.dart';
import 'package:app/src/pages/Map/bottomSearch.dart';


class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  _onPressed() {
    showMaterialModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (_) => SearchRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: MaterialButton(
            color: Colors.grey[300],
            elevation: 0,
            highlightElevation: 0,
            child: Text(
              'Buscar Destino',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            onPressed: _onPressed,
          ),
        ),
      ),
    );
  }
}

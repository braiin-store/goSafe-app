import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final _location = Location();
  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _location.requestPermission().then((status) => print(status));
  }

  _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    final jsonStr = await rootBundle.loadString('assets/mapStyle.json');
    await mapController.setMapStyle(jsonStr);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
      stream: _location.onLocationChanged(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        return GoogleMap(
          buildingsEnabled: false,
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(snap.data.latitude, snap.data.longitude),
          ),
        );
      },
    );
  }
}

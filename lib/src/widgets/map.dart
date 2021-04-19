import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/mapbox.dart';
import 'package:app/src/services/getTravel.dart';

class MapView extends StatefulWidget {
  MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final _location = Location();
  final controller = Get.find<GetTravelController>();

  final Set<Marker> markers = Set.from([]);
  final Set<Polyline> polylines = Set.from([]);

  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _location.requestPermission().then((status) => print(status));
    controller.addListener(() async {
      int drawroute = 0;
      if (controller.travel.source != null) {
        markers.add(Marker(
          markerId: MarkerId('source'),
          position: controller.travel.source,
        ));
        setState(() => print(drawroute++));
      }

      if (controller.travel.destiny != null) {
        markers.add(Marker(
          markerId: MarkerId('destiny'),
          position: controller.travel.destiny,
        ));
        setState(() => print(drawroute++));
      }

      if (drawroute == 2) {
        final routePoints = await Mapbox.instance.getRouteFromCoords(
          source: controller.travel.source,
          destiny: controller.travel.destiny,
        );
        polylines.add(
          Polyline(
            width: 3,
            color: Colors.black,
            points: routePoints,
            polylineId: PolylineId('travel'),
          ),
        );

        setState(() => print(drawroute = 0));
      }
    });
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

          markers: markers,
          polylines: polylines,
          onMapCreated: _onMapCreated,

          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(snap.data.latitude, snap.data.longitude),
          ),
        );
      },
    );
  }
}

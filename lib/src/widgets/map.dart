import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/mapbox.dart';
import 'package:app/src/services/getMap.dart';
import 'package:app/src/services/getTravel.dart';

class MapView extends StatefulWidget {
  MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final controller = Get.find<GetTravelController>();
  final mapController = Get.find<GetMapController>();

  final Set<Marker> markers = Set.from([]);
  final Set<Polyline> polylines = Set.from([]);

  @override
  void initState() {
    super.initState();
    mapController.location.requestPermission().then((value) => null);

    controller.addListener(() async {
      if (controller.travel.source != null) {
        markers.add(Marker(
          markerId: MarkerId('source'),
          position: controller.travel.source,
        ));
        setState(() => print(controller.travel.source));
      }

      if (controller.travel.destiny != null) {
        markers.add(Marker(
          markerId: MarkerId('destiny'),
          position: controller.travel.destiny,
        ));
        setState(() => print(controller.travel.destiny));
      }

      if (markers.length == 2) {
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

        setState(() => print(routePoints.length));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
      stream: mapController.location.onLocationChanged(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        mapController.setCurrentPosition(snap.data);
        return GoogleMap(
          // buildingsEnabled: false,
          // myLocationEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
                    
          markers: markers,
          polylines: polylines,
          onMapCreated: mapController.onMapCreated,

          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(snap.data.latitude, snap.data.longitude),
          ),
        );
      },
    );
  }
}

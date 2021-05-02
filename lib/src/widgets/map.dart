import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/getMap.dart';

class MapView extends GetView<GetMapController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
      stream: controller.location.onLocationChanged(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        controller.setCurrentPosition(snap.data);
        return GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          //
          markers: controller.markers,
          polylines: controller.polylines,
          //
          onCameraMove: controller.onCameraMove,
          onMapCreated: controller.onMapCreated,
          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(snap.data.latitude, snap.data.longitude),
          ),
        );
      },
    );
  }
}
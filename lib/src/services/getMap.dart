import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/mapbox.dart';
import 'package:app/src/services/getTravel.dart';

class GetMapController extends GetxController {
  LatLng _currentPosition;
  GoogleMapController _mapController;

  final _location = Location();
  final Set<Marker> markers = Set.from([]);
  final Set<Polyline> polylines = Set.from([]);
  final getTravel = Get.find<GetTravelController>();

  Location get location => _location;
  GoogleMapController get mapController => _mapController;

  GetMapController() {
    location.requestPermission().then((value) => null);
    getTravel.addListener(() async {
      if (getTravel.travel.source != null) {
        markers.add(Marker(
          markerId: MarkerId('source'),
          position: getTravel.travel.source,
        ));
      }

      if (getTravel.travel.destiny != null) {
        markers.add(Marker(
          markerId: MarkerId('destiny'),
          position: getTravel.travel.destiny,
        ));
      }
      print(markers.length);
      if (markers.length >= 2) {
        final route = await Mapbox.instance.getRouteFromCoords(
          source: getTravel.travel.source,
          destiny: getTravel.travel.destiny,
        );

        polylines.add(Polyline(
          width: 3,
          points: route,
          polylineId: PolylineId('travel'),
        ));
      }
    });
  }

  setCurrentPosition(LocationData data) {
    _currentPosition = LatLng(data.latitude, data.longitude);

    if (!getTravel.showMarker) {
      getTravel.setLastMarkerPosition(data.latitude, data.longitude);
    }
  }

  clear() {
    markers.clear();
    polylines.clear();
  }

  onCameraMove(CameraPosition position) {
    if (getTravel.showMarker) {
      getTravel.setLastMarkerPosition(
        position.target.latitude,
        position.target.longitude,
      );
    }
    update();
  }

  onMapCreated(GoogleMapController controller) async {
    this._mapController = controller;
    final jsonStr = await rootBundle.loadString('assets/mapStyle.json');
    await _mapController.setMapStyle(jsonStr);
    update();
  }

  getLocationCamera() async {
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(zoom: 15, bearing: 0, target: _currentPosition),
    ));
    update();
  }
}

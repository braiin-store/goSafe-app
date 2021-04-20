import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetMapController extends GetxController {
  Location _location = Location();

  LatLng _currentPosition;
  GoogleMapController _mapController;

  Location get location => _location;
  GoogleMapController get mapController => _mapController;

  setCurrentPosition(LocationData data) {
    _currentPosition = LatLng(data.latitude, data.longitude);
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

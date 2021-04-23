import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/models/travel.dart';
import 'package:app/src/services/here.dart';

enum MarkerType { source, destiny }

class GetTravelController extends GetxController {
  Travel _travel;

  String _sourceName;
  String _destinyName;

  MarkerType markerType;
  LatLng lastMarkerPosition;

  bool showMarker = false;
  Travel get travel => _travel;
  String get sourceName => _sourceName;
  String get destinyName => _destinyName;

  clear() {
    _travel = Travel();
    showMarker = false;

    markerType = null;
    _sourceName = null;
    _destinyName = null;
    update();
  }

  setLastMarkerPosition(double lat, double lng) {
    lastMarkerPosition = LatLng.fromJson([lat, lng]);
    update();
  }

  Future<bool> changeMarker({
    MarkerType markerType,
    bool selectLocation = false,
  }) async {
    bool tmp;
    if (selectLocation) {
      final places = await Here.instance.reverseGeoCode(lastMarkerPosition);

      if (this.markerType == MarkerType.source) {
        _travel.source = lastMarkerPosition;
        if (places.isNotEmpty) {
          _sourceName = places.first.address.label;
          tmp = true;
        }
      }

      if (this.markerType == MarkerType.destiny) {
        _travel.destiny = lastMarkerPosition;
        if (places.isNotEmpty) {
          _destinyName = places.first.address.label;
          tmp = false;
        }
      }
    }

    showMarker = !showMarker;
    this.markerType = markerType;

    update();
    return tmp;
  }

  updateTravel({
    double amount,
    LatLng source,
    LatLng destiny,
    String sourceName,
    String destinyName,
    MarkerType markerType,
  }) {
    if (amount != null) {
      this._travel.amount = amount;
    }

    if (source != null) {
      this._travel.source = source;
    }

    if (destiny != null) {
      this._travel.destiny = destiny;
    }

    if (sourceName != null) {
      this._sourceName = sourceName;
    }

    if (destinyName != null) {
      this._destinyName = destinyName;
    }
    update();
  }
}

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/models/travel.dart';

class GetTravelController extends GetxController {
  Travel _travel;

  String _sourceName;
  String _destinyName;

  Travel get travel => _travel;
  String get sourceName => _sourceName;
  String get destinyName => _destinyName;

  clear() {
    this._travel = Travel();
    update();
  }

  updateTravel({
    double amount,
    LatLng source,
    LatLng destiny,
    String sourceName,
    String destinyName,
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

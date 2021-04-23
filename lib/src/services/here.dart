import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/config.dart';
import 'package:app/src/models/place.dart';
import 'package:app/src/models/reversePlace.dart';

class Here {
  static final _instance = Here();
  static Here get instance => _instance;

  Future<List<Place>> getSuggestions(String query) async {
    if (query.isEmpty) return [];
    try {
      final res = await http.get(
        '${API.HERE_URL}?at=-17.7829,-63.1810&lang=es&apiKey=${API.HERE_KEY}&q=$query',
      );

      List items = json.decode(res.body)['items'];
      
      return items.map((item) => Place.fromJson(item)).toList();

    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<ReversePlace>> reverseGeoCode(LatLng loc) async {
    try {
      final res = await http.get(
        '${API.HERE_REV_URL}?lang=es-ES&apiKey=${API.HERE_KEY}&at=${loc.latitude},${loc.longitude}',
      );
      List items = json.decode(res.body)['items'];

      return items.map((item) => ReversePlace.fromJson(item)).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }
}

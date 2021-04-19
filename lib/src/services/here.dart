import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/src/config.dart';
import 'package:app/src/models/place.dart';

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
}

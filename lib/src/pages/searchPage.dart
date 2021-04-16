import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/models/place.dart';
import 'package:app/src/services/here.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer _debounce;
  List<Place> places = [];

  Widget _searchField() {
    final onChanged = (String query) {
      if (_debounce?.isActive ?? false) {
        _debounce.cancel();
      }
      _debounce = Timer(
        Duration(milliseconds: 500),
        () async {
          if (query.isNotEmpty) {
            this.places = await Here.instance.getSuggestions(query);
            setState(() => print(places.length));
          }
        },
      );
    };

    return TextField(
      style: TextStyle(fontSize: 18, color: Colors.grey),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar Ubicación',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _listSearchResult() {
    return Expanded(
      child: ListView.builder(
        itemCount: this.places.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final info = this.places[index].address.label.split(',');
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(info.removeAt(0), style: Get.textTheme.subtitle1),
                subtitle: Text(info.join(','), style: Get.textTheme.subtitle2),
                onTap: () => print(this.places[index].position.lat),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  Widget _buttonForMarker() {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => print('object'),
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  child: Icon(Icons.location_pin, color: Colors.green),
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 5),
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 5),
                  child: Text(
                    'Marcar en el Mapa',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          children: [
            _searchField(),
            _buttonForMarker(),
            _listSearchResult(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._debounce?.cancel();
    super.dispose();
  }
}

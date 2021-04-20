import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:app/src/models/place.dart';
import 'package:app/src/services/here.dart';
import 'package:app/src/services/getTravel.dart';

class SearchPage extends StatefulWidget {
  final destiny;
  SearchPage({Key key, this.destiny = false}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = Get.find<GetTravelController>();
  final _debounce = Debouncer(delay: Duration(milliseconds: 500));

  List<Place> places = [];

  Widget _searchField() {
    final onChanged = (String query) {
      if (query.isNotEmpty) {
        this._debounce(() async {
          this.places = await Here.instance.getSuggestions(query);
          setState(() => print(this.places.length));
        });
      }
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
    final onTap = (Place place) {
      final position = LatLng(place.position.lat, place.position.lng);

      if (this.widget.destiny) {
        controller.updateTravel(
          destiny: position,
          destinyName: place.address.label,
        );
        
        Get.back(result: controller.destinyName);
      } else {
        controller.updateTravel(
          source: position,
          sourceName: place.address.label,
        );
        Get.back(result: controller.sourceName);
      }
    };

    return Expanded(
      child: ListView.builder(
        itemCount: this.places.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final info = this.places[index].address?.label?.split(',');
          if (info == null) return Container();
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(info.removeAt(0), style: Get.textTheme.subtitle1),
                subtitle: Text(info.join(','), style: Get.textTheme.subtitle2),
                onTap: () => onTap(this.places[index]),
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
        onTap: () => Get.back(result: true),
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
    this._debounce.cancel();
    super.dispose();
  }
}

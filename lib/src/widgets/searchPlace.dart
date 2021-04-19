import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:app/src/models/place.dart';
import 'package:app/src/services/here.dart';

class SearchPlace extends SearchDelegate<Place> {
  final box = GetStorage();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, null),
    );
  }

  Widget _buildListTile(Place place, {Function onTap, IconData iconData}) {
    final info = place.address?.label?.split(',');
    return ListTile(
      leading: Icon(iconData),
      title: Text(info.removeAt(0), style: Get.textTheme.subtitle1),
      subtitle: Text(info.join(','), style: Get.textTheme.subtitle2),
      onTap: onTap,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: Here.instance.getSuggestions(query),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('No se encontraron Datos'));
        }
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (snap.data.isEmpty) {
          return this.buildSuggestions(context);
        }
        return ListView(
          children: snap.data.map((place) {
            return _buildListTile(place, iconData: Icons.map, onTap: () async {
              final history = this.box.read<List>('history') ?? [];

              if (!history.contains(place.toRawJson())) {
                history.insert(0, place.toRawJson());
              }

              await this.box.write('history', history);
              this.close(context, place);
            });
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final historyTiles = [
      ListTile(
        leading: Icon(Icons.location_pin, color: Colors.green),
        title: Text(
          'Marcar en el Mapa',
          style: TextStyle(color: Colors.green),
        ),
        onTap: () => this.close(context, Place(id: 'marker')),
      )
    ];

    this.box.read<List>('history')?.forEach((jsonStr) {
      final place = Place.fromRawJson(jsonStr);
      historyTiles.add(_buildListTile(
        place,
        iconData: Icons.history,
        onTap: () => this.close(context, place),
      ));
    });

    return ListView(children: historyTiles);
  }
}

import 'package:flutter/material.dart';
import 'package:app/src/services/mapbox.dart';

class InputLocation extends StatefulWidget {
  final String hintText;
  final IconData iconData;

  InputLocation({Key key, this.hintText, this.iconData}) : super(key: key);

  @override
  _InputLocationState createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  final double size = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        textAlign: TextAlign.justify,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            this.widget.iconData,
            color: Colors.black,
            size: size,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.add_location_outlined, size: size),
            color: Color(0xff14213d),
            onPressed: () => print('location picker'),
          ),
          hintText: this.widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: (value) async {
          if (value.isEmpty) return;
          final suggestions = await Mapbox.instance.getSuggestions(
            search: value,
          );
          suggestions.forEach((suggest) => suggest.address);
        },
      ),
    );
  }
}

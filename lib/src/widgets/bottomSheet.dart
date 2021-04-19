import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/getTravel.dart';
import 'package:app/src/widgets/searchPlace.dart';

class RequestBottomSheet extends StatefulWidget {
  RequestBottomSheet({Key key}) : super(key: key);

  @override
  _RequestBottomSheetState createState() => _RequestBottomSheetState();
}

class _RequestBottomSheetState extends State<RequestBottomSheet> {
  final sourceController = TextEditingController();
  final destinyController = TextEditingController();
  final controller = Get.find<GetTravelController>();

  Widget _drawerHeader() {
    return Container(
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xff80AF08),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(height: 2, width: Get.width / 6, color: Colors.white),
    );
  }

  Widget _requestField({
    Function onTap,
    String hintText,
    IconData iconData,
    TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        style: TextStyle(fontSize: 18, color: Colors.grey),
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(iconData),
          contentPadding: EdgeInsets.all(3),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        print(notification.extent);
        return true;
      },
      child: DraggableScrollableSheet(
        minChildSize: .035,
        maxChildSize: .5,
        initialChildSize: .2,
        builder: (sheetContext, scrollController) {
          return Material(
            borderRadius: BorderRadius.circular(20),
            child: ListView(
              padding: EdgeInsets.zero,
              controller: scrollController,
              children: [
                _drawerHeader(),
                _requestField(
                  hintText: 'Mi Ubicación',
                  iconData: Icons.push_pin,
                  controller: sourceController,
                  onTap: () async {
                    final place = await showSearch(
                      context: context,
                      delegate: SearchPlace(),
                    );

                    if (place == null) return;
                    if (place.id == 'marker') {
                      print("MUST SHOW MARKER ON MAP");
                      await scrollController.animateTo(
                        5,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      controller.updateTravel(
                        sourceName: place.address.label,
                        source: LatLng.fromJson(place.position.toJson()),
                      );
                      this.sourceController.text = place.address.label;
                    }
                  },
                ),
                _requestField(
                  hintText: 'Destino',
                  iconData: Icons.flag,
                  controller: destinyController,
                  onTap: () async {
                    final place = await showSearch(
                      context: context,
                      delegate: SearchPlace(),
                    );
                    if (place == null) return;
                    if (place.id == 'marker') {
                      print('MUST SHOW MARKER ON MAP');
                    } else {
                      controller.updateTravel(
                        destinyName: place.address.label,
                        destiny: LatLng.fromJson(place.position.toJson()),
                      );
                      this.destinyController.text = place.address.label;
                    }
                  },
                ),
                _requestField(
                  iconData: Icons.attach_money,
                  hintText: 'Ofrezca su Tarifa',
                ),
                _requestField(
                  iconData: Icons.chat,
                  hintText: 'Comentarios y deseos',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    this.sourceController.dispose();
    this.destinyController.dispose();
    super.dispose();
  }
}

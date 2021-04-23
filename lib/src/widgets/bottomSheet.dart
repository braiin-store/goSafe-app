import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/services/getTravel.dart';
import 'package:app/src/widgets/searchPlace.dart';

class RequestBottomSheet extends StatelessWidget {
  final sourceController = TextEditingController();
  final destinyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetTravelController>(
      dispose: (state) {
        sourceController.dispose();
        destinyController.dispose();
      },
      builder: (controller) {
        if (controller.showMarker) {
          return buildMarker(controller);
        }
        return buildBottomSheet(context, controller);
      },
    );
  }

  Widget requestField({
    Function onTap,
    String hintText,
    IconData iconData,
    TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextFormField(
        readOnly: onTap != null,
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

  Widget buildMarker(GetTravelController controller) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(0, -8),
          child: Center(child: Icon(Icons.location_pin, size: 35)),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              elevation: 1,
              color: Colors.green,
              padding: EdgeInsets.all(12),
              child: Text(
                'Seleccionar Ubicación',
                style: Get.textTheme.headline2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                controller.changeMarker(selectLocation: true).then((value) {
                  if (value) {
                    this.sourceController.text = controller.sourceName;
                  } else {
                    this.destinyController.text = controller.destinyName;
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottomSheet(
    BuildContext context,
    GetTravelController controller,
  ) {
    return DraggableScrollableSheet(
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
              Container(
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff80AF08),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  height: 4,
                  width: Get.width / 6,
                  color: Colors.white,
                ),
              ),
              requestField(
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
                    await controller.changeMarker(
                      markerType: MarkerType.source,
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
              requestField(
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
                    await controller.changeMarker(
                      markerType: MarkerType.destiny,
                    );
                  } else {
                    controller.updateTravel(
                      destinyName: place.address.label,
                      destiny: LatLng.fromJson(place.position.toJson()),
                    );
                    this.destinyController.text = place.address.label;
                  }
                },
              ),
              requestField(
                iconData: Icons.attach_money,
                hintText: 'Ofrezca su Tarifa',
              ),
              requestField(
                iconData: Icons.chat,
                hintText: 'Comentarios y deseos',
              ),
            ],
          ),
        );
      },
    );
  }
}

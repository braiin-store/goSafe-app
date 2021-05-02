import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app/src/config.dart';
import 'package:app/src/models/user.dart';
import 'package:app/src/services/getTravel.dart';
import 'package:app/src/widgets/searchPlace.dart';

class RequestBottomSheet extends StatelessWidget {
  final sourceController = TextEditingController();
  final destinyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    TextInputType type,
    Function(String) onChanged,
    TextEditingController controller,
    String Function(String) validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextFormField(
        onTap: onTap,
        keyboardType: type,
        validator: validator,
        readOnly: onTap != null,
        controller: controller,
        style: TextStyle(fontSize: 18, color: Colors.grey),
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(iconData),
          contentPadding: EdgeInsets.all(3),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: onChanged,
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

  List getTextAndColor(VehicleType vehicleType) {
    if (vehicleType == VehicleType.motorcycle) {
      return ['Moto', Colors.yellow[50]];
    } else if (vehicleType == VehicleType.car) {
      return ['Auto', Colors.lightBlue[50]];
    } else {
      return ['Otros', Colors.pink[50]];
    }
  }

  Widget vehicleButton({
    IconData iconData,
    VehicleType vehicleType,
    GetTravelController controller,
  }) {
    final data = getTextAndColor(vehicleType);

    return Padding(
      padding: EdgeInsets.all(5),
      child: MaterialButton(
        elevation: 1,
        color: vehicleType == controller.vehicleType ? data.last : null,
        minWidth: Get.width / 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.all(3),
              child: Icon(iconData, size: 45),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Text(data.first, style: Get.textTheme.headline3),
            ),
          ],
        ),
        onPressed: () => controller.updateTravel(vehicleType: vehicleType),
      ),
    );
  }

  Widget buildBottomSheet(
    BuildContext context,
    GetTravelController controller,
  ) {
    return DraggableScrollableSheet(
      minChildSize: .035,
      maxChildSize: .45,
      initialChildSize: .2,
      builder: (sheetContext, scrollController) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.zero,
              controller: scrollController,
              children: [
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 3,
                    color: Colors.white,
                    width: Get.width / 6,
                  ),
                ),
                requestField(
                  hintText: 'Mi Ubicación',
                  iconData: Icons.push_pin,
                  controller: sourceController,
                  validator: (value) {
                    return value.isEmpty ? 'Seleccione una Ubicación' : null;
                  },
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
                  validator: (value) {
                    return value.isEmpty ? 'Seleccione una Ubicación' : null;
                  },
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
                  type: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  onChanged: (value) {
                    final amount = double.tryParse(value);
                    if (amount != null) {
                      controller.updateTravel(amount: amount);
                    }
                  },
                  validator: (value) {
                    return int.tryParse(value) == null
                        ? 'Introduzca un Número Válido'
                        : null;
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      vehicleButton(
                        controller: controller,
                        iconData: Icons.motorcycle,
                        vehicleType: VehicleType.motorcycle,
                      ),
                      vehicleButton(
                        vehicleType: VehicleType.car,
                        controller: controller,
                        iconData: Icons.car_repair,
                      ),
                      vehicleButton(
                        vehicleType: VehicleType.other,
                        controller: controller,
                        iconData: Icons.business,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: Get.width / 5,
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Get.theme.primaryColor,
                    child: Text(
                      'Solicitar Auto',
                      style: Get.textTheme.headline2,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        final user = User.fromRawJson(box.read('user'));
                        controller.requestTravel(user);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

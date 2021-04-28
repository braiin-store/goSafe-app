import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:international_phone_input/international_phone_input.dart';

import 'package:app/src/config.dart';
import 'package:app/src/services/getPhone.dart';

class EnterPhonePage extends StatelessWidget {
  final controller = Get.put(GetPhoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          inputPhone(),
          Positioned(
            bottom: 20,
            child: confirmButton(),
          ),
        ],
      ),
    );
  }

  _onPhoneNumberChange(String phone, String international, String isoCode) {
    this.controller.isoCode.value = isoCode;
    this.controller.phoneNumber.value = phone;
    this.controller.international.value = international;
  }

  Widget inputPhone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 75, left: 25),
          child: Text(
            'Registra Tu Número Celular',
            style: Get.textTheme.headline4,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            'Enviaremos Un Código a tu Celular',
            style: Get.textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: InternationalPhoneInput(
            initialSelection: 'BO',
            errorText: 'Introduzca un nro válido',
            hintStyle: Get.textTheme.bodyText2,
            labelStyle: Get.textTheme.bodyText2,
            onPhoneNumberChange: _onPhoneNumberChange,
          ),
        ),
      ],
    );
  }

  Widget confirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 7, vertical: 30),
      child: MaterialButton(
        color: Get.theme.primaryColor,
        minWidth: Get.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text('CONTINUAR', style: Get.textTheme.headline2),
        onPressed: () {
          if (this.controller.phoneNumber.value.isEmpty) return;
          if (this.controller.international.value.isEmpty) return;
          controller
              .verifyPhone()
              .then((_) async => await Get.toNamed(Routes.confirm.toString()))
              .catchError((e) => print(e));
        },
      ),
    );
  }
}

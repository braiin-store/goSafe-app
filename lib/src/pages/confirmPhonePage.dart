import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../config.dart';

import 'package:app/src/services/getPhone.dart';

class ConfirmPhonePage extends GetView<GetPhoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          enterPhone(),
          Positioned(bottom: 20, child: confirmButton()),
        ],
      ),
    );
  }

  Widget enterPhone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 75, left: 25),
          child: Text(
            'Ingresa el Código',
            style: Get.textTheme.headline4,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            'Se envió un código por SMS',
            style: Get.textTheme.bodyText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Text(controller.international.value,
              style: Get.textTheme.bodyText1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: InkWell(
            child: Text(
              'Editar Número de Celular',
              style: Get.textTheme.headline6,
            ),
            onTap: () => Get.back(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: Get.width / 3),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: controller.smsCode.value,
            style: Get.textTheme.bodyText2,
            decoration: InputDecoration(
              hintText: 'eg 123456',
              hintStyle: Get.textTheme.subtitle2,
              icon: Icon(Icons.sms),
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) => print(controller.smsCode.value = value),
            validator: (val) {
              if (int.tryParse(val) == null) {
                return 'Valor no válido';
              }

              return val.length != 6 ? '6 digitos requerido' : null;
            },
          ),
        ),
      ],
    );
  }

  Widget confirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 7, vertical: 30),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        minWidth: Get.width / 1.5,
        color: Get.theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text('CONTINUAR', style: Get.textTheme.headline2),
        onPressed: () {
          if (controller.smsCode.value.length != 6) return;
          if (int.tryParse(controller.smsCode.value) == null) return;

          FirebaseAuth.instance
              .signInWithCredential(
                PhoneAuthProvider.credential(
                  smsCode: controller.smsCode.value,
                  verificationId: controller.verificationId.value,
                ),
              )
              .then((_) async => await Get.toNamed(Routes.home.toString()))
              .catchError((error) => print(error));
        },
      ),
    );
  }
}

import 'package:block_input/block_input_controller.dart';
import 'package:block_input/block_input_keyboard_type.dart';
import 'package:block_input/block_input_style.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:block_input/block_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ConfirmPhonePage extends StatefulWidget {
  final PhoneNumber phoneNumber;
  ConfirmPhonePage({Key key, this.phoneNumber}) : super(key: key);

  @override
  _ConfirmPhonePageState createState() => _ConfirmPhonePageState();
}

class _ConfirmPhonePageState extends State<ConfirmPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: _enterPhone),
      bottomNavigationBar: _confirmButton,
    );
  }

  Widget get _enterPhone {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 75, left: 25),
          child: Text(
            'Ingresa el Código',
            style: Get.textTheme.headline4,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            'Se envió un código por SMS',
            style: Get.textTheme.bodyText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Text(
            this.widget.phoneNumber?.phoneNumber ?? '+591 78506823',
            // style: Get.textTheme.bodyText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: InkWell(
            child: Text(
              'Editar Número de Celular',
              style: Get.textTheme.headline6,
            ),
            onTap: () => print('Back'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: BlockInput(
            controller: BlockInputController(4),
            keyboardType: BlockInputKeyboardType.number,
            axisAlignment: MainAxisAlignment.spaceAround,
            style: BlockInputStyle(
              width: size.width / 6,
              textStyle: Get.textTheme.headline3,
              backgroundColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xff80AF08)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _confirmButton {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 7, vertical: 30),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Color(0xff709e07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          'CONTINUAR',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => null,
      ),
    );
  }
}

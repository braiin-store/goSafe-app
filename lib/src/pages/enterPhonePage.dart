import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EnterPhonePage extends StatefulWidget {
  EnterPhonePage({Key key}) : super(key: key);

  @override
  _EnterPhonePageState createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: _enterPhone),
      bottomNavigationBar: _confirmButton,
    );
  }

  Widget get _enterPhone {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: InternationalPhoneNumberInput(
            keyboardType: TextInputType.phone,
            locale: 'es',
            selectorConfig: SelectorConfig(
              backgroundColor: Colors.white,
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
            ),
            inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onInputChanged: (value) => print(value),
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

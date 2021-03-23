import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/widgets/forms.dart';
import 'package:app/src/widgets/background.dart';

class FinishRegisterPage extends StatefulWidget {
  FinishRegisterPage({Key key}) : super(key: key);

  @override
  _FinishRegisterPageState createState() => _FinishRegisterPageState();
}

class _FinishRegisterPageState extends State<FinishRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(drawUpDown: false, div: 8),
          _bodyForm,
        ],
      ),
    );
  }

  Widget get _bodyForm {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100, bottom: 30),
          child: Text('Ya Estamos finalizando', style: Get.textTheme.headline5),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text('Foto de Perfil'),
        ),
        Container(
          width: Get.size.width / 2,
          height: Get.size.height / 5,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_camera_outlined,
                color: Colors.black38,
                size: 40,
              ),
              Text('Sube tu foto', style: Get.textTheme.bodyText1),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FinishForm(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: MaterialButton(
            color: Color(0xff222222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Finalizar Registro',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => print('HI!!'),
          ),
        ),
      ],
    );
  }
}

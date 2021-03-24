import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/models/user.dart';

class InputForm extends StatelessWidget {
  final bool hidden;
  final String label;
  final IconData iconData;
  final Function(String) onInput;
  final TextInputType keyboardType;

  const InputForm({
    Key key,
    this.label,
    this.hidden = false,
    this.onInput,
    this.iconData,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return TextFormField(
      onChanged: onInput,
      obscureText: hidden,
      textAlign: TextAlign.left,
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.dark,
      style: TextStyle(
        fontSize: 18,
        color: Color(0xff222222),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.black,
            width: size.width * .85,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.w500),
        prefixIcon: Icon(iconData, size: 31, color: Color(0xff222222)),
        alignLabelWithHint: false,
        contentPadding: EdgeInsets.only(bottom: 0),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final User user;
  SignInForm({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.ltr,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 7, 10, 5),
            child: InputForm(
              label: 'Correo Electrónico',
              iconData: Icons.mail_outline,
              onInput: (value) => print(this.user.email = value),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 13),
            child: InputForm(
              hidden: true,
              label: 'Contraseña',
              iconData: Icons.lock_outline,
              onInput: (value) => print(this.user.password = value),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final User user;
  const SignUpForm({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.ltr,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 7, 10, 5),
            child: InputForm(
              label: 'Nombre',
              iconData: Icons.person_outline,
              onInput: (value) => print(this.user.name = value),
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 7, 10, 5),
            child: InputForm(
              label: 'Correo Electrónico',
              iconData: Icons.mail_outline,
              onInput: (value) => print(this.user.email = value),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 13),
            child: InputForm(
              hidden: true,
              label: 'Contraseña',
              iconData: Icons.lock_outline,
              onInput: (value) => print(this.user.password = value),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 13),
            child: InputForm(
              hidden: true,
              label: 'Confirmar Contraseña',
              iconData: Icons.lock_open_sharp,
              onInput: (value) => print(value),
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}

class FinishForm extends StatelessWidget {
  const FinishForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 7, 10, 5),
          child: InputForm(
            label: 'Dirección Domiciliaria',
            iconData: Icons.home_outlined,
            onInput: (value) => print(value),
            keyboardType: TextInputType.streetAddress,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 13),
          child: InputForm(
            hidden: true,
            label: 'Contacto de Auxilio',
            iconData: Icons.verified_user_outlined,
            onInput: (value) => print(value),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../apis/authApi.dart';
import 'package:app/src/models/user.dart';
import 'package:app/src/services/getImage.dart';

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
    return TextFormField(
      onChanged: onInput,
      obscureText: hidden,
      textAlign: TextAlign.left,
      keyboardType: keyboardType,
      scrollPadding: EdgeInsets.zero,
      style: Get.textTheme.bodyText2,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: label,
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(iconData, size: 30),
        labelStyle: Get.textTheme.bodyText2,
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: buildForm(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: MaterialButton(
            color: Color(0xff222222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _tryLogin(_formKey, this.user),
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
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
              keyboardType: TextInputType.emailAddress,
              onInput: (value) => print(this.user.email = value),
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
  final user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: buildForm(context),
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: MaterialButton(
            color: Color(0xff222222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Registrarse',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _tryLogin(_formKey, this.user),
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
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

_tryLogin(GlobalKey<FormState> key, User user) async {
  if (key.currentState.validate()) {
    key.currentState.save();

    final auth = user.name == null
        ? AuthApi.instance.signIn(user)
        : AuthApi.instance.signUp(user);

    await Get.toNamed(
      await auth ? Routes.home.toString() : Routes.phone.toString(),
    );
  }
}

class FinishForm extends GetView<GetImageController> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: buildForm(),
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
            onPressed: () async {
              if (this.controller.image.value?.existsSync() ?? false) {
                if (this.formkey.currentState.validate()) {
                  final address = controller.address.value;
                  final contact = controller.contact.value;

                  controller.addAddress(Address(name: address));
                  controller.addContact(Contact(number: contact));

                  this.controller.uploadIMG();
                  await Get.toNamed(Routes.home.toString());
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildForm() {
    return Form(
      key: formkey,
      child: Column(
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
              keyboardType: TextInputType.streetAddress,
              onInput: (val) => controller.address.value = val,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 13),
            child: InputForm(
              label: 'Contacto de Auxilio',
              iconData: Icons.verified_user_outlined,
              keyboardType: TextInputType.number,
              onInput: (val) => controller.contact.value = val,
            ),
          ),
        ],
      ),
    );
  }
}

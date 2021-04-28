import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:app/src/services/getImage.dart';

import 'package:app/src/widgets/forms.dart';
import 'package:app/src/widgets/background.dart';
import 'package:image_picker/image_picker.dart';

class FinishRegisterPage extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final imgController = Get.put(GetImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(drawUpDown: false, div: 8),
          SingleChildScrollView(
            child: bodyForm(),
          ),
        ],
      ),
    );
  }

  Widget buildImg() {
    return Obx(() {
      if (this.imgController.image.value?.existsSync() ?? false) {
        return InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              imgController.image.value,
              fit: BoxFit.contain,
            ),
          ),
          onTap: () => imgController.pickImage(ImageSource.gallery),
          onLongPress: () => imgController.pickImage(ImageSource.camera),
        );
      }
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_camera_outlined, color: Colors.black38, size: 40),
            Text('Sube tu foto', style: Get.textTheme.bodyText1),
          ],
        ),
        onTap: () => imgController.pickImage(ImageSource.gallery),
        onLongPress: () => imgController.pickImage(ImageSource.camera),
      );
    });
  }

  Widget bodyForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0, bottom: 30),
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
          child: buildImg(),
        ),
        FinishForm(),
      ],
    );
  }
}

import 'dart:io';
import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/src/config.dart';
import 'package:app/src/models/user.dart';

class GetImageController extends GetxController {
  User user;
  final image = Rx<File>();

  final address = ''.obs;
  final contact = ''.obs;

  GetImageController() {
    final userStr = box.read('user') ?? User();
    this.user = userStr is String ? User.fromRawJson(userStr) : userStr;
  }

  Future pickImage(ImageSource imageSource) async {
    File file = await ImagePicker.pickImage(source: imageSource);
    image.value = file;
  }

  addAddress(Address address) {
    int i = 0;
    while (i++ < user.addresses.length) {
      if (user.addresses[i].id == address.id) {
        user.addresses[i] = address;
        break;
      }
    }

    if (i == user.addresses.length) {
      user.addresses.add(address);
    }
    // TODO: must call API user.addAddresss
    update();
  }

  addContact(Contact contact) {
    int i = 0;
    while (i++ < user.contacts.length) {
      if (user.contacts[i].id == contact.id) {
        user.contacts[i] = contact;
        break;
      }
    }

    if (i == user.contacts.length) {
      user.contacts.add(contact);
    }
    // TODO: must call API user.addContact
    update();
  }

  uploadIMG() async {
    final base64 = base64Encode(image.value.readAsBytesSync());
    print('base64 => $base64');
    // await http.post(
    //   '${API.URL}/clientes',
    //   headers: {'Content-type': 'application/json'},
    //   body: user.toRawJson(),
    // );

    // TODO: must call API user - Cliente
    update();
  }
}

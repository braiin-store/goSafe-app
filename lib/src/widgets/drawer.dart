import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:app/src/models/user.dart';

import '../config.dart';

const listTiles = [
  // ['Ciudad', Icons.add_location_outlined],
  // ['Seguridad', Icons.security_outlined],
  ['Mis viajes', Icons.access_time_outlined, Routes.mytrips],
  ['Soporte', Icons.chat_outlined, Routes.support],
  ['Acerca de', Icons.info_outline, Routes.about],
  ['Métodos de Pago', Icons.credit_card_outlined, Routes.payment],
];

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key key}) : super(key: key);

  List buildList() {
    final user = User.fromRawJson(box.read<String>('user'));

    final list = <Widget>[
      DrawerHeader(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width / 4,
              height: Get.width / 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://pbs.twimg.com/profile_images/1189365653100212224/IUhyMElL_400x400.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.name, style: Get.textTheme.headline3),
                InkWell(
                  child: Text('Ver'),
                  onTap: () => print('User Profile'),
                )
              ],
            )
          ],
        ),
      ),
    ];

    list.addAll(
      listTiles.map(
        (tile) => ListTile(
            title: Text(tile.first, style: Get.textTheme.bodyText2),
            leading: Icon(tile[1], color: Colors.black),
            onTap: () async => await Get.toNamed(tile.last.toString())),
      ),
    );

    list.add(
      Padding(
        padding: EdgeInsets.only(top: Get.height / 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.directions_walk, size: 43),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Text('Modo Pasajero', style: Get.textTheme.headline2),
              ),
            ),
          ],
        ),
      ),
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 2 / 3,
      child: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: buildList(),
        ),
      ),
    );
  }
}

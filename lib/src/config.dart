import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:app/src/pages/homePage.dart';
import 'package:app/src/pages/loginPage.dart';

import 'package:app/src/pages/enterPhonePage.dart';
import 'package:app/src/pages/confirmPhonePage.dart';
import 'package:app/src/pages/finishRegisterPage.dart';

import 'package:app/src/pages/drawer/about.dart';
import 'package:app/src/pages/drawer/myTrips.dart';
import 'package:app/src/pages/drawer/payment.dart';
import 'package:app/src/pages/drawer/support.dart';

class API {
  // VIRTUAL ANDROID http://10.0.2.2:8000/api
  // VIRTUAL IOS     http://localhost:8000/api
  static const URL = "https://goafe-app.herokuapp.com/api";
  static const HERE_URL = "https://autosuggest.search.hereapi.com/v1/autosuggest";
  static const HERE_REV_URL = "https://revgeocode.search.hereapi.com/v1/revgeocode";

  static const HERE_KEY = "sSce-1bGwzasrYDmDVkrHVRdINGO4W_nvOOr3v1JdRY";
  static const MAPBOX_KEY = "pk.eyJ1IjoiZWxyb2lyIiwiYSI6ImNraWM4NXloZjB6bjAycG12MGIxMnd1NjkifQ.7rCNg1jNBd9v6RPTnY6cVQ";
}

final box = GetStorage();

enum Routes {
  home,
  phone,
  login,
  finish,
  confirm,

  // drawer-routes
  about,
  payment,
  support,
  mytrips,
}

final pages = [
  GetPage(name: Routes.home.toString(),     page: () => HomePage()),
  GetPage(name: Routes.login.toString(),    page: () => LoginPage()),
  GetPage(name: Routes.phone.toString(),    page: () => EnterPhonePage()),
  GetPage(name: Routes.confirm.toString(),  page: () => ConfirmPhonePage()),
  GetPage(name: Routes.finish.toString(),   page: () => FinishRegisterPage()),

  // drawer routes
  GetPage(name: Routes.about.toString(),    page: () => AboutPage()),
  GetPage(name: Routes.payment.toString(),  page: () => PaymentPage()),
  GetPage(name: Routes.support.toString(),  page: () => SupportPage()),
  GetPage(name: Routes.mytrips.toString(),  page: () => MyTripsPage()),
];

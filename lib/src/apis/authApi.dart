import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app/src/env.dart' as env;
import 'package:app/src/models/user.dart';

class AuthApi {
  static final AuthApi _instance = AuthApi();
  static AuthApi get instance => _instance;

  Future<bool> signUp(User user) async {
    try {
      final res = await http.post(
        '${env.API_URL}/signup',
        headers: {'Content-type': 'application/json'},
        body: user.toRawJson(),
      );
      final data = json.decode(res.body);
      if (data['error'] == null) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> signIn(User user) async {
    try {
      final res = await http.post(
        '${env.API_URL}/signin',
        headers: {'Content-Type': 'Application/json'},
        body: user.toRawJson(),
      );

      if (res.statusCode != 500) {
        user = User.fromRawJson(res.body);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}

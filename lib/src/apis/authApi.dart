import 'package:http/http.dart' as http;

import 'package:app/src/config.dart';
import 'package:app/src/models/user.dart';

class AuthApi {
  static final AuthApi _instance = AuthApi();
  static AuthApi get instance => _instance;

  Future<bool> signUp(User user) async {
    try {
      final res = await http.post(
        '${API.URL}/signup',
        headers: {'Content-type': 'application/json'},
        body: user.toRawJson(),
      );

      if (res.statusCode != 500) {
        user = User.fromRawJson(res.body);
        await box.write('user', user.toRawJson());

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signIn(User user) async {
    try {
      final res = await http.post(
        '${API.URL}/signin',
        headers: {'Content-Type': 'application/json'},
        body: user.toRawJson(),
      );

      if (res.statusCode != 500) {
        user = User.fromRawJson(res.body);
        await box.write('user', user.toRawJson());

        final token = box.read<String>('firebaseToken');

        return token != null ? true : null;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}

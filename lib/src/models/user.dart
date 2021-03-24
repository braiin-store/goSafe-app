import 'dart:convert';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.password,
    this.roleId,
  });

  int id;
  int roleId;

  String name;
  String email;
  String token;
  String password;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id        : json["id"],
      name      : json["name"],
      email     : json["email"],
      token     : json["token"],
      password  : json["password"],
      roleId    : json["RoleId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id"        : id,
      "name"      : name,
      "email"     : email,
      "token"     : token,
      "password"  : password,
      "RoleId"    : roleId,
    };
  }
}
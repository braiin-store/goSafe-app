import 'dart:convert';
class User {
  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.password,
    this.roleId,
    this.contacts,
    this.addresses,
  }) {
    this.contacts ??= [];
    this.addresses ??= [];
  }

  int id;
  int roleId;

  String name;
  String email;
  String token;
  String password;
  
  List<Contact> contacts;
  List<Address> addresses;

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
      contacts  : json['contacts']?.map((e) => Contact.fromRawJson(e))?.toList() ?? [], 
      addresses : json['addresses']?.map((e) => Address.fromRawJson(e))?.toList() ?? [],
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
      "contacts"  : List.from(contacts.map((e) => e.toJson())),
      "addresses" : List.from(addresses.map((e) => e.toJson())),
    };
  }
}

class Contact {
  int id;
  String number;
  String description;

  Contact({
    this.id, 
    this.number, 
    this.description
  });

  String toRawJson() => json.encode(toJson());
  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id          : json['id'],
      number      : json['number'],
      description : json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id"          : id,
      "number"      : number,
      "description" : description,
    };
  }
}

class Address {
  int id;
  String name;

  Address({
    this.id, 
    this.name,
  });

  String toRawJson() => json.encode(toJson());
  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id          : json['id'],
      name        : json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id"          : id,
      "name"        : name,
    };
  }
}


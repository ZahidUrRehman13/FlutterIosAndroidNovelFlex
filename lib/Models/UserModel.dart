// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    this.img,
    required this.accessToken,
  });

  String id;
  String fname;
  String lname;
  String email;
  String password;
  dynamic img;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    password: json["password"],
    img: json["img"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fname": fname,
    "lname": lname,
    "email": email,
    "password": password,
    "img": img,
    "accessToken": accessToken,
  };
}


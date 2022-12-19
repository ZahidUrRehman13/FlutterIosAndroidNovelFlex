// To parse this JSON data, do
//
//     final forgetPasswordModel = forgetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel forgetPasswordModelFromJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordModelToJson(ForgetPasswordModel data) => json.encode(data.toJson());

class ForgetPasswordModel {
  ForgetPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.password,
    this.accessToken,
    this.createdAt,
  });

  String? id;
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? accessToken;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    password: json["password"],
    accessToken: json["accessToken"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fname": fname,
    "lname": lname,
    "email": email,
    "password": password,
    "accessToken": accessToken,
    "created_at": createdAt!.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final authorProfileModel = authorProfileModelFromJson(jsonString);

import 'dart:convert';

AuthorProfileModel authorProfileModelFromJson(String str) => AuthorProfileModel.fromJson(json.decode(str));

String authorProfileModelToJson(AuthorProfileModel data) => json.encode(data.toJson());

class AuthorProfileModel {
  AuthorProfileModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory AuthorProfileModel.fromJson(Map<String, dynamic> json) => AuthorProfileModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.subscribers,
    this.username,
    this.img,
    this.level,
  });

  String? subscribers;
  String? username;
  String? img;
  String? level;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    subscribers: json["subscribers"],
    username: json["username"],
    img: json["img"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "subscribers": subscribers,
    "username": username,
    "img": img,
    "level": level,
  };
}

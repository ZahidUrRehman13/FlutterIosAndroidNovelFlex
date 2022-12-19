// To parse this JSON data, do
//
//     final profileStatusModel = profileStatusModelFromJson(jsonString);

import 'dart:convert';

ProfileStatusModel profileStatusModelFromJson(String str) => ProfileStatusModel.fromJson(json.decode(str));

String profileStatusModelToJson(ProfileStatusModel data) => json.encode(data.toJson());

class ProfileStatusModel {
  ProfileStatusModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory ProfileStatusModel.fromJson(Map<String, dynamic> json) => ProfileStatusModel(
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
    this.userType,
  });

  String? userType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "user_type": userType,
  };
}

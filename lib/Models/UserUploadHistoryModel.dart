// To parse this JSON data, do
//
//     final userUploadHistoryModel = userUploadHistoryModelFromJson(jsonString);

import 'dart:convert';

UserUploadHistoryModel userUploadHistoryModelFromJson(String str) => UserUploadHistoryModel.fromJson(json.decode(str));

String userUploadHistoryModelToJson(UserUploadHistoryModel data) => json.encode(data.toJson());

class UserUploadHistoryModel {
  UserUploadHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory UserUploadHistoryModel.fromJson(Map<String, dynamic> json) => UserUploadHistoryModel(
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
    this.id,
    this.bookTitle,
    this.bookImage,
    this.categoryTitle,
    this.titleAr,
    this.status,
    this.userId,
    this.publishedDate,
    this.modifiedDate,
    this.views,
  });

  String? id;
  String? bookTitle;
  String? bookImage;
  String? categoryTitle;
  String? titleAr;
  String? status;
  String? userId;
  DateTime? publishedDate;
  dynamic modifiedDate;
  String? views;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bookTitle: json["bookTitle"],
    bookImage: json["bookImage"],
    categoryTitle: json["categoryTitle"],
    titleAr: json["titleAR"],
    status: json["status"],
    userId: json["userId"],
    publishedDate: DateTime.parse(json["publishedDate"]),
    modifiedDate: json["modifiedDate"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "bookImage": bookImage,
    "categoryTitle": categoryTitle,
    "titleAR": titleAr,
    "status": status,
    "userId": userId,
    "publishedDate": publishedDate!.toIso8601String(),
    "modifiedDate": modifiedDate,
    "views": views,
  };
}

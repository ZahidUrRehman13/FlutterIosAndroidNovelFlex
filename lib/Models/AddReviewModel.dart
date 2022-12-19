// To parse this JSON data, do
//
//     final addReviewModel = addReviewModelFromJson(jsonString);

import 'dart:convert';

AddReviewModel addReviewModelFromJson(String str) => AddReviewModel.fromJson(json.decode(str));

String addReviewModelToJson(AddReviewModel data) => json.encode(data.toJson());

class AddReviewModel {
  AddReviewModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory AddReviewModel.fromJson(Map<String, dynamic> json) => AddReviewModel(
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
    this.rating,
    this.comments,
    this.bookImage,
  });

  String? id;
  String? bookTitle;
  String? rating;
  String? comments;
  String? bookImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bookTitle: json["bookTitle"],
    rating: json["rating"],
    comments: json["comments"],
    bookImage: json["bookImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "rating": rating,
    "comments": comments,
    "bookImage": bookImage,
  };
}

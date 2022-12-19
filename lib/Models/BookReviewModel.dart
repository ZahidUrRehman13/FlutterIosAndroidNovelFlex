// To parse this JSON data, do
//
//     final bookReviewModel = bookReviewModelFromJson(jsonString);

import 'dart:convert';

BookReviewModel bookReviewModelFromJson(String str) => BookReviewModel.fromJson(json.decode(str));

String bookReviewModelToJson(BookReviewModel data) => json.encode(data.toJson());

class BookReviewModel {
  BookReviewModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory BookReviewModel.fromJson(Map<String, dynamic> json) => BookReviewModel(
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
    this.username,
    this.userImage,
  });

  String? id;
  String? bookTitle;
  String? rating;
  String? comments;
  String? bookImage;
  String? username;
  dynamic userImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bookTitle: json["bookTitle"],
    rating: json["rating"],
    comments: json["comments"],
    bookImage: json["bookImage"],
    username: json["username"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "rating": rating,
    "comments": comments,
    "bookImage": bookImage,
    "username": username,
    "userImage": userImage,
  };
}

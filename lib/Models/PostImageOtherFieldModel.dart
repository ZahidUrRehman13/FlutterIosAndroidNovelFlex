// To parse this JSON data, do
//
//     final postImageOtherFieldModel = postImageOtherFieldModelFromJson(jsonString);

import 'dart:convert';

PostImageOtherFieldModel postImageOtherFieldModelFromJson(String str) => PostImageOtherFieldModel.fromJson(json.decode(str));

String postImageOtherFieldModelToJson(PostImageOtherFieldModel data) => json.encode(data.toJson());

class PostImageOtherFieldModel {
  PostImageOtherFieldModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory PostImageOtherFieldModel.fromJson(Map<String, dynamic> json) => PostImageOtherFieldModel(
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
    this.categoryId,
    this.bookTitle,
    this.description,
    this.language,
    this.bookImage,
  });

  String? id;
  String? categoryId;
  String? bookTitle;
  String? description;
  String? language;
  String? bookImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    categoryId: json["categoryId"],
    bookTitle: json["bookTitle"],
    description: json["description"],
    language: json["language"],
    bookImage: json["bookImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "bookTitle": bookTitle,
    "description": description,
    "language": language,
    "bookImage": bookImage,
  };
}

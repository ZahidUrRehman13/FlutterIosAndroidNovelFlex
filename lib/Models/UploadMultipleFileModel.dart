// To parse this JSON data, do
//
//     final uploadMultipleFileModel = uploadMultipleFileModelFromJson(jsonString);

import 'dart:convert';

UploadMultipleFileModel uploadMultipleFileModelFromJson(String str) => UploadMultipleFileModel.fromJson(json.decode(str));

String uploadMultipleFileModelToJson(UploadMultipleFileModel data) => json.encode(data.toJson());

class UploadMultipleFileModel {
  UploadMultipleFileModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory UploadMultipleFileModel.fromJson(Map<String, dynamic> json) => UploadMultipleFileModel(
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
    this.bookTitle,
    this.description,
    this.language,
    this.status,
    this.categoryId,
    this.categoryTitle,
    this.chapters,
  });

  String? id;
  String? bookTitle;
  String? description;
  String? language;
  String? status;
  String? categoryId;
  String? categoryTitle;
  List<Chapter>? chapters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    bookTitle: json["bookTitle"],
    description: json["description"],
    language: json["language"],
    status: json["status"],
    categoryId: json["categoryId"],
    categoryTitle: json["categoryTitle"],
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "description": description,
    "language": language,
    "status": status,
    "categoryId": categoryId,
    "categoryTitle": categoryTitle,
    "chapters": List<dynamic>.from(chapters!.map((x) => x.toJson())),
  };
}

class Chapter {
  Chapter({
    this.name,
    this.image,
    this.url,
  });

  String? name;
  dynamic image;
  String? url;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    name: json["name"],
    image: json["image"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "url": url,
  };
}

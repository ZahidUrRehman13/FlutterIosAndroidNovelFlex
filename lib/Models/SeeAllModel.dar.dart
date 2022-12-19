// To parse this JSON data, do
//
//     final seeAllModel = seeAllModelFromJson(jsonString);

import 'dart:convert';

SeeAllModel seeAllModelFromJson(String str) => SeeAllModel.fromJson(json.decode(str));

String seeAllModelToJson(SeeAllModel data) => json.encode(data.toJson());

class SeeAllModel {
  SeeAllModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory SeeAllModel.fromJson(Map<String, dynamic> json) => SeeAllModel(
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
    this.description,
    this.bookImage,
    this.language,
  });

  String? id;
  String? bookTitle;
  Description? description;
  String? bookImage;
  Language? language;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bookTitle: json["bookTitle"],
    description: descriptionValues.map[json["description"]],
    bookImage: json["bookImage"],
    language: languageValues.map[json["language"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "description": descriptionValues.reverse[description],
    "bookImage": bookImage,
    "language": languageValues.reverse[language],
  };
}

enum Description { BOOK_ADDED_SUCCESSFULLY }

final descriptionValues = EnumValues({
  "book added successfully": Description.BOOK_ADDED_SUCCESSFULLY
});

enum Language { ENG, ARB }

final languageValues = EnumValues({
  "arb": Language.ARB,
  "eng": Language.ENG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

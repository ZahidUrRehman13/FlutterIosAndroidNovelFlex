// // To parse this JSON data, do
// //
// //     final bookDetailsModel = bookDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// BookDetailsModel bookDetailsModelFromJson(String str) => BookDetailsModel.fromJson(json.decode(str));
//
// String bookDetailsModelToJson(BookDetailsModel data) => json.encode(data.toJson());
//
// class BookDetailsModel {
//   BookDetailsModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   int? status;
//   String? message;
//   Data? data;
//
//   factory BookDetailsModel.fromJson(Map<String, dynamic> json) => BookDetailsModel(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data!.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.id,
//     this.bookTitle,
//     this.description,
//     this.bookImage,
//     this.publishedDate,
//     this.modifiedDate,
//     this.language,
//     this.userId,
//     this.author,
//     this.categories,
//     this.chapters,
//   });
//
//   String? id;
//   String? bookTitle;
//   String? description;
//   String? bookImage;
//   DateTime? publishedDate;
//   dynamic? modifiedDate;
//   String? language;
//   String? userId;
//   Author? author;
//   List<Category>? categories;
//   List<Chapter>? chapters;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     bookTitle: json["bookTitle"],
//     description: json["description"],
//     bookImage: json["bookImage"],
//     publishedDate: DateTime.parse(json["publishedDate"]),
//     modifiedDate: json["modifiedDate"],
//     language: json["language"],
//     userId: json["userId"],
//     author: Author.fromJson(json["author"]),
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "bookTitle": bookTitle,
//     "description": description,
//     "bookImage": bookImage,
//     "publishedDate": publishedDate!.toIso8601String(),
//     "modifiedDate": modifiedDate,
//     "language": language,
//     "userId": userId,
//     "author": author!.toJson(),
//     "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
//     "chapters": List<dynamic>.from(chapters!.map((x) => x.toJson())),
//   };
// }
//
// class Author {
//   Author({
//     this.id,
//     this.name,
//     this.img,
//   });
//
//   String? id;
//   String? name;
//   dynamic? img;
//
//   factory Author.fromJson(Map<String, dynamic> json) => Author(
//     id: json["id"],
//     name: json["name"],
//     img: json["img"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "img": img,
//   };
// }
//
// class Category {
//   Category({
//     this.id,
//     this.titleEn,
//     this.titleAr,
//   });
//
//   String? id;
//   String? titleEn;
//   String? titleAr;
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     titleEn: json["titleEn"],
//     titleAr: json["titleAr"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "titleEn": titleEn,
//     "titleAr": titleAr,
//   };
// }
//
// class Chapter {
//   Chapter({
//     this.name,
//     this.image,
//     this.url,
//   });
//
//   String? name;
//   String? image;
//   String? url;
//
//   factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
//     name: json["name"],
//     image: json["image"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "image": image,
//     "url": url,
//   };
// }
// To parse this JSON data, do
//
//     final bookDetailsModel = bookDetailsModelFromJson(jsonString);

import 'dart:convert';

BookDetailsModel bookDetailsModelFromJson(String str) => BookDetailsModel.fromJson(json.decode(str));

String bookDetailsModelToJson(BookDetailsModel data) => json.encode(data.toJson());

class BookDetailsModel {
  BookDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) => BookDetailsModel(
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
    this.bookImage,
    this.publishedDate,
    this.modifiedDate,
    this.language,
    this.userId,
    this.author,
    this.categories,
    this.chapters,
  });

  String? id;
  String? bookTitle;
  String? description;
  String? bookImage;
  DateTime? publishedDate;
  dynamic modifiedDate;
  String? language;
  String? userId;
  Author? author;
  List<Category>? categories;
  List<Chapter>? chapters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    bookTitle: json["bookTitle"],
    description: json["description"],
    bookImage: json["bookImage"],
    publishedDate: DateTime.parse(json["publishedDate"]),
    modifiedDate: json["modifiedDate"],
    language: json["language"],
    userId: json["userId"],
    author: Author.fromJson(json["author"]),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "description": description,
    "bookImage": bookImage,
    "publishedDate": publishedDate!.toIso8601String(),
    "modifiedDate": modifiedDate,
    "language": language,
    "userId": userId,
    "author": author!.toJson(),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "chapters": List<dynamic>.from(chapters!.map((x) => x.toJson())),
  };
}

class Author {
  Author({
    this.id,
    this.name,
    this.img,
  });

  String? id;
  String? name;
  dynamic img;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
  };
}

class Category {
  Category({
    this.id,
    this.titleEn,
    this.titleAr,
  });

  String? id;
  String? titleEn;
  String? titleAr;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    titleEn: json["titleEn"],
    titleAr: json["titleAr"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titleEn": titleEn,
    "titleAr": titleAr,
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

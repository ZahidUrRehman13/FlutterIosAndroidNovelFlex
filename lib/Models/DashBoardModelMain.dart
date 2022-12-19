// // To parse this JSON data, do
// //
// //     final dashBoardModelMain = dashBoardModelMainFromJson(jsonString);
//
// import 'dart:convert';
//
// DashBoardModelMain dashBoardModelMainFromJson(String str) => DashBoardModelMain.fromJson(json.decode(str));
//
// String dashBoardModelMainToJson(DashBoardModelMain data) => json.encode(data.toJson());
//
// class DashBoardModelMain {
//   DashBoardModelMain({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   int? status;
//   String? message;
//   List<Datum>? data;
//
//   factory DashBoardModelMain.fromJson(Map<String, dynamic> json) => DashBoardModelMain(
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.categoryId,
//     this.categoryTitle,
//     this.books,
//   });
//
//   String? categoryId;
//   String? categoryTitle;
//   List<Book>? books;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     categoryId: json["categoryId"],
//     categoryTitle: json["categoryTitle"],
//     books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categoryId": categoryId,
//     "categoryTitle": categoryTitle,
//     "books": List<dynamic>.from(books!.map((x) => x.toJson())),
//   };
// }
//
// class Book {
//   Book({
//     this.id,
//     this.bookTitle,
//     this.description,
//     this.bookImage,
//     this.createdAt,
//     this.language,
//   });
//
//   String? id;
//   String? bookTitle;
//   Description? description;
//   String? bookImage;
//   DateTime? createdAt;
//   Language? language;
//
//   factory Book.fromJson(Map<String, dynamic> json) => Book(
//     id: json["id"],
//     bookTitle: json["bookTitle"],
//     description: descriptionValues.map[json["description"]],
//     bookImage: json["bookImage"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     language: languageValues.map[json["language"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "bookTitle": bookTitle,
//     "description": descriptionValues.reverse[description],
//     "bookImage": bookImage,
//     "createdAt": createdAt!.toIso8601String(),
//     "language": languageValues.reverse[language],
//   };
// }
//
// enum Description { NEW_BOOK_DESCRIPTION, BOOK_ADDED_SUCCESSFULLY }
//
// final descriptionValues = EnumValues({
//   "book added successfully": Description.BOOK_ADDED_SUCCESSFULLY,
//   "new book description": Description.NEW_BOOK_DESCRIPTION
// });
//
// enum Language { ENG, ARB }
//
// final languageValues = EnumValues({
//   "arb": Language.ARB,
//   "eng": Language.ENG
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
// To parse this JSON data, do
//
//     final dashBoardModelMain = dashBoardModelMainFromJson(jsonString);

import 'dart:convert';

DashBoardModelMain dashBoardModelMainFromJson(String str) => DashBoardModelMain.fromJson(json.decode(str));

String dashBoardModelMainToJson(DashBoardModelMain data) => json.encode(data.toJson());

class DashBoardModelMain {
  DashBoardModelMain({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory DashBoardModelMain.fromJson(Map<String, dynamic> json) => DashBoardModelMain(
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
    this.categoryId,
    this.categoryTitle,
    this.titleAr,
    this.books,
  });

  String? categoryId;
  String? categoryTitle;
  String? titleAr;
  List<Book>? books;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["categoryId"],
    categoryTitle: json["categoryTitle"],
    titleAr: json["titleAr"],
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryTitle": categoryTitle,
    "titleAr": titleAr,
    "books": List<dynamic>.from(books!.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    this.id,
    this.bookTitle,
    this.description,
    this.bookImage,
    this.createdAt,
  });

  String? id;
  String? bookTitle;
  String? description;
  String? bookImage;
  DateTime? createdAt;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    bookTitle: json["bookTitle"],
    description: json["description"],
    bookImage: json["bookImage"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "description": description,
    "bookImage": bookImage,
    "createdAt": createdAt!.toIso8601String(),
  };
}

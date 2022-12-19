// To parse this JSON data, do
//
//     final dropDownCategoriesModel = dropDownCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<DropDownCategoriesModel> dropDownCategoriesModelFromJson(String str) => List<DropDownCategoriesModel>.from(json.decode(str).map((x) => DropDownCategoriesModel.fromJson(x)));

String dropDownCategoriesModelToJson(List<DropDownCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropDownCategoriesModel {
  DropDownCategoriesModel({
    this.categoryId,
    this.title,
    this.titleAr,
  });

  String? categoryId;
  String? title;
  String? titleAr;

  factory DropDownCategoriesModel.fromJson(Map<String, dynamic> json) => DropDownCategoriesModel(
    categoryId: json["category_id"],
    title: json["title"],
    titleAr: json["titleAr"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "title": title,
    "titleAr": titleAr,
  };
}

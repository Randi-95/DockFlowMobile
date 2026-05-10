import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final int id;
  final String name;
  final String? iconName;
  final int total;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconName,
    required this.total,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        iconName: json["icon_name"],
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_name": iconName,
        "total": total,
      };
}

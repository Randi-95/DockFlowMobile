import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final int id;
  final String name;
  final String skuCode;
  final String categoryName;
  final int categoryId;
  final int stockQty;
  final String unit;
  final double price;
  final String rackLocation;
  final String? imageUrl;
  final String status;
  final String statusColor;

  ProductModel({
    required this.id,
    required this.name,
    required this.skuCode,
    required this.categoryName,
    required this.categoryId,
    required this.stockQty,
    required this.unit,
    required this.price,
    required this.rackLocation,
    this.imageUrl,
    required this.status,
    required this.statusColor,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        skuCode: json["sku_code"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        stockQty: json["stock_qty"],
        unit: json["unit"],
        price: (json["price"] is String)
            ? double.parse(json["price"])
            : json["price"].toDouble(),
        rackLocation: json["rack_location"],
        imageUrl: json["image_url"],
        status: json["status"],
        statusColor: json["status_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku_code": skuCode,
        "category_name": categoryName,
        "category_id": categoryId,
        "stock_qty": stockQty,
        "unit": unit,
        "price": price,
        "rack_location": rackLocation,
        "image_url": imageUrl,
        "status": status,
        "status_color": statusColor,
      };
}

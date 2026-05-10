import 'dart:convert';

InventoryStatistics inventoryStatisticsFromJson(String str) =>
    InventoryStatistics.fromJson(json.decode(str));

String inventoryStatisticsToJson(InventoryStatistics data) =>
    json.encode(data.toJson());

class InventoryStatistics {
  final int totalItem;
  final int totalStock;
  final int lowStock;
  final int inOrder;

  InventoryStatistics({
    required this.totalItem,
    required this.totalStock,
    required this.lowStock,
    required this.inOrder,
  });

  factory InventoryStatistics.fromJson(Map<String, dynamic> json) =>
      InventoryStatistics(
        totalItem: json["total_item"] ?? 0,
        totalStock: json["total_stock"] ?? 0,
        lowStock: json["low_stock"] ?? 0,
        inOrder: json["in_order"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "total_item": totalItem,
        "total_stock": totalStock,
        "low_stock": lowStock,
        "in_order": inOrder,
      };
}

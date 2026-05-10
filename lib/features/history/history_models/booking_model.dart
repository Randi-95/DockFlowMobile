import 'dart:convert';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  final int id;
  final String bookingNumber;
  final String status;
  final String? vesselName;
  final String createdAt;
  final String? estimatedDeliveryDate;
  final double totalEstimatedPrice;
  final int itemsCount;

  BookingModel({
    required this.id,
    required this.bookingNumber,
    required this.status,
    this.vesselName,
    required this.createdAt,
    this.estimatedDeliveryDate,
    required this.totalEstimatedPrice,
    required this.itemsCount,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        bookingNumber: json["booking_number"],
        status: json["status"],
        vesselName: json["vessel_name"],
        createdAt: json["created_at"],
        estimatedDeliveryDate: json["estimated_delivery_date"],
        totalEstimatedPrice: (json["total_estimated_price"] is String)
            ? double.parse(json["total_estimated_price"])
            : json["total_estimated_price"].toDouble(),
        itemsCount: json["items_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_number": bookingNumber,
        "status": status,
        "vessel_name": vesselName,
        "created_at": createdAt,
        "estimated_delivery_date": estimatedDeliveryDate,
        "total_estimated_price": totalEstimatedPrice,
        "items_count": itemsCount,
      };
}

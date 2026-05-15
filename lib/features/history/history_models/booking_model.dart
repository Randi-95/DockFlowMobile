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
  final String? barcodeUrl;
  final String? dockLocation;
  final List<BookingItemModel> items;

  BookingModel({
    required this.id,
    required this.bookingNumber,
    required this.status,
    this.vesselName,
    required this.createdAt,
    this.estimatedDeliveryDate,
    required this.totalEstimatedPrice,
    required this.itemsCount,
    this.barcodeUrl,
    this.dockLocation,
    required this.items,
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
        barcodeUrl: json["barcode_url"],
        dockLocation: json["dock_location"],
        items: json["items"] != null
            ? List<BookingItemModel>.from(
                json["items"].map((x) => BookingItemModel.fromJson(x)))
            : [],
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
        "barcode_url": barcodeUrl,
        "dock_location": dockLocation,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class BookingItemModel {
  final String productName;
  final int qty;
  final double price;
  final String? imageUrl;

  BookingItemModel({
    required this.productName,
    required this.qty,
    required this.price,
    this.imageUrl,
  });

  factory BookingItemModel.fromJson(Map<String, dynamic> json) =>
      BookingItemModel(
        productName: json["product_name"],
        qty: json["qty"],
        price: (json["price"] is String)
            ? double.parse(json["price"])
            : json["price"].toDouble(),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "qty": qty,
        "price": price,
        "image_url": imageUrl,
      };
}

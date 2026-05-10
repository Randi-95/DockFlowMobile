import 'dart:convert';

Stock stockFromJson(String str) => Stock.fromJson(json.decode(str));

String stockToJson(Stock data) => json.encode(data.toJson());

class Stock {
    final int stock;
    final int totalItem;
    final int totalStokRendah;

    Stock({
        required this.stock,
        required this.totalItem,
        required this.totalStokRendah,
    });

    factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        stock: json["stock"],
        totalItem: json["totalItem"],
        totalStokRendah: json["totalStokRendah"],
    );

    Map<String, dynamic> toJson() => {
        "stock": stock,
        "totalItem": totalItem,
        "totalStokRendah": totalStokRendah,
    };
}

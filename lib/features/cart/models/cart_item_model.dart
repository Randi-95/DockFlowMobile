class CartItem {
  final int productId;
  final String name;
  final String? imageUrl;
  final int price;
  final int quantity;
  final String unit;

  CartItem({
    required this.productId,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }
}

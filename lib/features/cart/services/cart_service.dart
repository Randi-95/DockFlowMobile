import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dockflow_app/features/cart/models/cart_item_model.dart';

class CartService {
  static const String _cartKey = 'cart_items';

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      Iterable decoded = jsonDecode(cartJson);
      return List<CartItem>.from(decoded.map((x) => CartItem.fromJson(x)));
    }
    return [];
  }

  Future<void> addToCart(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    List<CartItem> cartItems = await getCartItems();
    
    // Check if item already exists
    int existingIndex = cartItems.indexWhere((i) => i.productId == item.productId);
    if (existingIndex != -1) {
      // Update quantity
      cartItems[existingIndex] = CartItem(
        productId: cartItems[existingIndex].productId,
        name: cartItems[existingIndex].name,
        imageUrl: cartItems[existingIndex].imageUrl,
        price: cartItems[existingIndex].price,
        quantity: cartItems[existingIndex].quantity + item.quantity,
        unit: cartItems[existingIndex].unit,
      );
    } else {
      cartItems.add(item);
    }

    String updatedCartJson = jsonEncode(cartItems.map((i) => i.toJson()).toList());
    await prefs.setString(_cartKey, updatedCartJson);
  }

  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<CartItem> cartItems = await getCartItems();
    
    cartItems.removeWhere((item) => item.productId == productId);
    
    String updatedCartJson = jsonEncode(cartItems.map((i) => i.toJson()).toList());
    await prefs.setString(_cartKey, updatedCartJson);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}

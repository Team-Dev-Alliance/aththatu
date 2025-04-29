import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // List to store cart items
  List<Map<String, dynamic>> _cartItems = [
    {
      'shopName': 'Chathu Clay Pots',
      'productName': 'Cacti Pot, Medium size',
      'unitPrice': 400.0,
      'imageUrl': 'assets/cart_clay_pot.png',
      'quantity': 1,
    },
    {
      'shopName': 'Lanka Garden Supplies',
      'productName': 'Soil Bag - 5kg',
      'unitPrice': 200.0,
      'imageUrl': 'assets/soil_bag.png',
      'quantity': 2,
    },
  ];

  // Getter for cart items
  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Add item to cart
  void addItem(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Update quantity of an item
  void updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _cartItems.removeAt(index);
    } else {
      _cartItems[index]['quantity'] = newQuantity;
    }
    notifyListeners();
  }

  // Calculate subtotal
  double calculateSubtotal() {
    return _cartItems.fold(0, (sum, item) {
      return sum + (item['unitPrice'] * item['quantity']);
    });
  }

  // Get total number of items in cart (including quantities)
  int get totalItems {
    return _cartItems.fold(0, (sum, item) {
      return sum + (item['quantity'] as int);
    });
  }

  // Clear cart
  void clearCart() {
    _cartItems = [];
    notifyListeners();
  }
}

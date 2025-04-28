import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String orderId;
  final double price;
  final DateTime timestamp;
  final List<Product> products;
  final Customer customer;

  Order({
    required this.orderId,
    required this.price,
    required this.timestamp,
    required this.products,
    required this.customer,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      orderId: data['orderId'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      products: (data['products'] as List<dynamic>)
          .map((p) => Product.fromMap(p as Map<String, dynamic>))
          .toList(),
      customer: Customer.fromMap(data['customer'] as Map<String, dynamic>),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final int quantity;

  Product({
    required this.name,
    required this.imageUrl,
    required this.quantity,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }
}

class Customer {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String avatarUrl;
  final String memberSince;

  Customer({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.avatarUrl,
    required this.memberSince,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      memberSince: map['memberSince'] ?? '',
    );
  }
}
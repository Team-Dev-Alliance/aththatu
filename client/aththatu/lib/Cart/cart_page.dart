import 'package:flutter/material.dart';
import 'cart_item_tile.dart';
import '../components/navigation_bar.dart' as nav;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy cart data (you can later fetch this from provider or backend)
  List<Map<String, dynamic>> cartItems = [
    {
      'shopName': 'Chathu Clay Pots',
      'productName': 'Cacti Pot, Medium size',
      'unitPrice': 6969.0,
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': 1,
    },
    {
      'shopName': 'Lanka Garden Supplies',
      'productName': 'Soil Bag - 5kg',
      'unitPrice': 1499.0,
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': 2,
    },
  ];

  final double deliveryFee = 500.0;
  int _currentNavIndex = 2; // Cart tab selected

  double _calculateSubtotal() {
    return cartItems.fold(0, (sum, item) {
      return sum + (item['unitPrice'] * item['quantity']);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      bottomNavigationBar: nav.NavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
            if (index == 1) {
              Navigator.pushReplacementNamed(context, '/categories');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/cart');
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          });
        },
      ),
      body: Column(
        children: [
          // Cart items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemTile(
                  shopName: item['shopName'],
                  productName: item['productName'],
                  unitPrice: item['unitPrice'],
                  // imageUrl: item['imageUrl'],
                  key: ValueKey(index),
                  onQuantityChanged: (newQty) => _updateQuantity(index, newQty),
                  initialQuantity: item['quantity'],
                );
              },
            ),
          ),

          // Totals + Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(top: BorderSide(color: Colors.black12)),
            ),
            child: Column(
              children: [
                _buildPriceRow("Subtotal", subtotal),
                _buildPriceRow("Delivery Fee", deliveryFee),
                const Divider(),
                _buildPriceRow("Total", total, isBold: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          // Checkout logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Proceeding to checkout...")),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Proceed to Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text("Rs. ${amount.toStringAsFixed(2)}",
              style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}

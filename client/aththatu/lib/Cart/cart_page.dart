import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item_tile.dart';
import 'cart_provider.dart';
import '../components/navigation_bar.dart' as nav;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final double deliveryFee = 500.0;
  int _currentNavIndex = 2; // Cart tab selected

  @override
  Widget build(BuildContext context) {
    // Get the cart provider
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    
    double subtotal = cartProvider.calculateSubtotal();
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
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
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
            child: cartItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add items to get started',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Browse Products'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
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
                    onQuantityChanged: (newQty) => cartProvider.updateQuantity(index, newQty),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Cart/cart_provider.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  Widget _buildWishlistCard(BuildContext context) {
    // Access the CartProvider to add items to cart
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Added',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Apr 21, 2025', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 8),
            // Product and arrow
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Chathu Clay Pots',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            // Product details
            Row(
              children: [
                const Placeholder(
                    fallbackHeight: 50, fallbackWidth: 50), // Product image
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cacti Pot, Medium size',
                          style: TextStyle(color: Colors.grey[600])),
                      const Text('Rs. 6,969',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Add to cart button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add to cart logic
                  cartProvider.addItem({
                    'shopName': 'Chathu Clay Pots',
                    'productName': 'Cacti Pot, Medium size',
                    'unitPrice': 6969.0,
                    'imageUrl': 'https://via.placeholder.com/150',
                    'quantity': 1,
                  });
                  
                  // Show confirmation snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Item added to cart'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/cart');
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildWishlistCard(context),
        _buildWishlistCard(context), // Add more cards as needed
      ],
    );
  }
}

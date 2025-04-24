import 'package:flutter/material.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  Widget _buildWishlistCard() {
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
                  // TODO: Implement add to cart logic
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
        _buildWishlistCard(),
        _buildWishlistCard(), // Add more cards as needed
      ],
    );
  }
}

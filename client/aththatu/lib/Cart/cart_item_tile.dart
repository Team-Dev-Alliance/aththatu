import 'package:flutter/material.dart';

class CartItemTile extends StatefulWidget {
  final String shopName;
  final String productName;
  final double unitPrice;
  // final String imageUrl;
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;

  const CartItemTile({
    super.key,
    required this.shopName,
    required this.productName,
    required this.unitPrice,
    // required this.imageUrl,
    required this.initialQuantity,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  late int quantity;
  
  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      widget.onQuantityChanged(quantity);
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        widget.onQuantityChanged(quantity);
      } else {
        // Removing item from cart
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item removed from cart")),
        );
        quantity = 0;
        widget.onQuantityChanged(quantity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) return const SizedBox(); // Don't display if removed

    double totalPrice = widget.unitPrice * quantity;

    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop name and arrow
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.shopName,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                const Icon(Icons.image, size: 60, color: Colors.grey),
                const SizedBox(width: 10),
                // Text + price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Rs. ${widget.unitPrice}',
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
                // Quantity controls
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: _decrementQuantity,
                        icon: const Icon(Icons.remove)),
                    Text('$quantity'),
                    IconButton(
                        onPressed: _incrementQuantity,
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Total: Rs. ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

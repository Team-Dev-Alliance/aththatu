import 'package:flutter/material.dart';
import 'product_page.dart'; // Make sure you import your ProductPage

class ProductTile extends StatelessWidget {
  final String name;
  final int price;
  final List<String> images;
  final String description;
  final List<String> variations;

  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.images,
    required this.description,
    required this.variations,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductPage on click
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProductPage(
                  productName: name,
                  imageUrls: images,
                  description: description,
                  variations: variations,
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  images.isNotEmpty
                      ? images[0]
                      : 'assets/no_image.png', // Placeholder image if no images are available
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Product Name
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Product Price
            Text(
              'Rs $price',
              style: const TextStyle(color: Colors.green, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

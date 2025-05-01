import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productName;
  final List<String> imageUrls;
  final String description;
  final List<String> variations;

  const ProductPage({
    super.key,
    required this.productName,
    required this.imageUrls,
    required this.description,
    required this.variations,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  String? _selectedVariation;

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % widget.imageUrls.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + widget.imageUrls.length) %
          widget.imageUrls.length;
    });
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedVariation =
        widget.variations.isNotEmpty ? widget.variations[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Container(
              height: 300,
              color: Colors.grey[200],
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      widget.imageUrls[_currentImageIndex],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 130,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _previousImage,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 130,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _nextImage,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.productName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),

            const SizedBox(height: 16),

            // Variations Dropdown
            if (widget.variations.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  value: _selectedVariation,
                  onChanged: (value) {
                    setState(() {
                      _selectedVariation = value;
                    });
                  },
                  items:
                      widget.variations.map((variation) {
                        return DropdownMenuItem(
                          value: variation,
                          child: Text(variation),
                        );
                      }).toList(),
                ),
              ),

            const SizedBox(height: 16),

            // Quantity Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Quantity:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decreaseQuantity,
                  ),
                  Text('$_quantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Add to Cart Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // You can add your cart logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'product_tile.dart';
import 'filter_buttons.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedFilter = 'Popular'; // Default filter

  // Mock product data
  List<Map<String, dynamic>> products = [
    {
      'name': 'Clay Pot A',
      'price': 2500,
      'popularity': 90,
      'dateAdded': DateTime(2025, 4, 1),
      'images': [
        'https://via.placeholder.com/300.png?text=Clay+Pot+A+1',
        'https://via.placeholder.com/300.png?text=Clay+Pot+A+2',
      ],
      'description':
          'Beautiful handmade clay pot A, perfect for plants or decor.',
      'variations': ['Small', 'Medium', 'Large'],
    },
    {
      'name': 'Clay Pot B',
      'price': 3000,
      'popularity': 75,
      'dateAdded': DateTime(2025, 4, 10),
      'images': [
        'https://via.placeholder.com/300.png?text=Clay+Pot+B+1',
        'https://via.placeholder.com/300.png?text=Clay+Pot+B+2',
      ],
      'description': 'Elegant clay pot B with intricate designs.',
      'variations': ['Medium', 'Large'],
    },
    {
      'name': 'Clay Pot C',
      'price': 1500,
      'popularity': 95,
      'dateAdded': DateTime(2025, 3, 25),
      'images': [
        'https://via.placeholder.com/300.png?text=Clay+Pot+C+1',
        'https://via.placeholder.com/300.png?text=Clay+Pot+C+2',
      ],
      'description': 'Compact clay pot C, ideal for kitchen herbs.',
      'variations': ['Small', 'Medium'],
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> sortedList = List.from(products);
    if (selectedFilter == 'Popular') {
      sortedList.sort((a, b) => b['popularity'].compareTo(a['popularity']));
    } else if (selectedFilter == 'Recent') {
      sortedList.sort((a, b) => b['dateAdded'].compareTo(a['dateAdded']));
    }
    return sortedList;
  }

  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner with back button
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://via.placeholder.com/400x200.png?text=Shop+Banner',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Shop Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Chathu Clay Pots', // You can replace this dynamically if needed
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Filter Buttons
            FilterButtons(selected: selectedFilter, onSelect: updateFilter),

            const SizedBox(height: 8),

            // Products Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductTile(
                    name: product['name'],
                    price: product['price'],
                    images: product['images'],
                    description: product['description'],
                    variations: product['variations'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

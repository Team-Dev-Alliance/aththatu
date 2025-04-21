import 'package:flutter/material.dart';
// import '../components/title_bar.dart';

class SellerOrdersPage extends StatelessWidget {
  const SellerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Orders'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Orders
              const Text(
                'New Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildOrderCard(
                orderId: '00214',
                product: 'Cacti pots',
                image: 'assets/cacti_pots.jpg',
                quantity: 2,
                orderedBy: 'K.L. Chathurangi',
                phone: '070 123 4567',
                address: 'miller road, battaramulla',
              ),
              _buildOrderCard(
                orderId: '00254',
                product: 'Spice Jars',
                image: 'assets/spice_jars.jpg',
                quantity: 3,
                orderedBy: 'Saman Kumara',
                phone: '070 123 4567',
                address: '255, Ruwan Maga, Dodangoda',
              ),
              _buildOrderCard(
                orderId: '00614',
                product: 'Clay Bowls',
                image: 'assets/clay_bowls.jpg',
                quantity: 4,
                orderedBy: 'Saman Kumara',
                phone: '070 123 4567',
                address: '255, Ruwan Maga, Dodangoda',
              ),
              const SizedBox(height: 16),
              // Previous Orders
              const Text(
                'Previous Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildOrderCard(
                orderId: '00214',
                product: 'Clay water pots',
                image: 'assets/clay_water_pots.jpg',
                quantity: 1,
                orderedBy: 'K.L. Chathurangi',
                phone: '070 123 4567',
                address: 'miller road, battaramulla',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String product,
    required String image,
    required int quantity,
    required String orderedBy,
    required String phone,
    required String address,
  }) {
    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order: $orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(product, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Quantity: $quantity'),
                  Text('Order by: $orderedBy'),
                  Text('Phone No: $phone'),
                  Text('Address: $address'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
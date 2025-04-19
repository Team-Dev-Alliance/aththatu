import 'package:flutter/material.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> with SingleTickerProviderStateMixin {
  late TabController _orderTabController;

  @override
  void initState() {
    super.initState();
    _orderTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _orderTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Orders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        TabBar(
          controller: _orderTabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.yellow[600],
          tabs: const [
            Tab(text: 'View all'),
            Tab(text: 'To pay'),
            Tab(text: 'To ship'),
            Tab(text: 'Shipped'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _orderTabController,
            children: [
              _buildOrderList(),
              _buildOrderList(),
              _buildOrderList(),
              _buildOrderList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildOrderCard(),
      ],
    );
  }

  Widget _buildOrderCard() {
    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completed', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Feb 11, 2025', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Chathu Clay Pots',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Placeholder(fallbackHeight: 50, fallbackWidth: 50), // Image placeholder
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cacti Pot, Medium size', style: TextStyle(color: Colors.grey[600])),
                      const Text('Rs. 6,969', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Text('Qty: 1'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Total (1 item): Rs. 6,969',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
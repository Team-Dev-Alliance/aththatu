import 'package:flutter/material.dart';
import '../components/title_bar.dart';
import '../components/navigation_bar.dart' as nav;
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentNavIndex = 0;
  List<dynamic> _vendors = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fetchVendors();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchVendors() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/sellerProfile/sellerDetails/'),
      );
      if (response.statusCode == 200) {
        setState(() {
          _vendors = json.decode(response.body)['sellers'];
        });
      } else {
        print('Failed to load vendors');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(),
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
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search on Aththatu',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Category Tabs
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: 'Bakes'),
              Tab(text: 'Clothes'),
              Tab(text: 'Handcrafts'),
              Tab(text: 'Misceleaneous'),
            ],
          ),
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Delivery Time'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[50],
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Filters'),
                  ),
                ),
              ],
            ),
          ),
          // Vendor List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVendorList('Bakes'),
                _buildVendorList('Clothes'),
                _buildVendorList('Handcrafts'),
                _buildVendorList('Misceleaneous'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorList(String category) {
    final filteredVendors =
        _vendors.where((vendor) {
          return vendor['category']?.toLowerCase() == category.toLowerCase();
        }).toList();
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount:filteredVendors.length, // Example: 3 vendor cards
      itemBuilder: (context, index) {
        final vendor = filteredVendors[index];
        final tags = vendor['tags'] as List<dynamic>? ?? [];
        return Card(
          color: Colors.green[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor['name'] ?? 'Unknown Vendor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                       Wrap(
                      spacing: 8,
                      children: tags.map<Widget>((tag) {
                        return OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green[100],
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(tag),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Visit Page'),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey, // Placeholder for vendor image
                  child: Icon(Icons.person, size: 40),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

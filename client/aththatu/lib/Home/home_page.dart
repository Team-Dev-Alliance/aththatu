import 'package:flutter/material.dart';
import '../components/title_bar.dart';
import '../components/navigation_bar.dart' as nav;
import '../ShopPage/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              Tab(text: 'Misc.'),
            ],
          ),
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            // child: Row(
            //   children: [
            //     Expanded(
            //       child: OutlinedButton(
            //         onPressed: () {},
            //         style: OutlinedButton.styleFrom(
            //           backgroundColor: Colors.green[100],
            //           side: BorderSide.none,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //         ),
            //         child: const Text('Delivery Time'),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: OutlinedButton(
            //         onPressed: () {},
            //         style: OutlinedButton.styleFrom(
            //           backgroundColor: Colors.green[50],
            //           side: BorderSide.none,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //         ),
            //         child: const Text('Filters'),
            //       ),
            //     ),
            //   ],
            // ),
          ),
          // Vendor List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBakesVendorList(),
                _buildClothesVendorList(),
                _buildHandcraftsVendorList(),
                _buildMiscellaneousVendorList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBakesVendorList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3, // Example: 3 vendor cards
      itemBuilder: (context, index) {
        // Different bakes vendors
        final List<Map<String, dynamic>> bakesVendors = [
          {
            'name': 'Ayana Home Bakes',
            'categories': ['Cakes', 'Confectionaries'],
            'rating': 5,
            'image': 'assets/ayana.png',
          },
          {
            'name': 'Dulce Sweet Treats',
            'categories': ['Cupcakes', 'Pastries'],
            'rating': 4,
            'image': 'assets/dulce.png',
          },
          {
            'name': 'Flour Power Bakery',
            'categories': ['Bread', 'Cookies'],
            'rating': 5,
            'image': 'assets/flour.png',
          },
        ];

        final vendor = bakesVendors[index];

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
                        vendor['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var category in vendor['categories'])
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.green[100],
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(category),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var i = 0; i < vendor['rating']; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          for (var i = vendor['rating']; i < 5; i++)
                            const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopPage(),
                            ),
                          );
                        },
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
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.green[200],
                  backgroundImage: AssetImage(vendor['image']),
                  // child: Text(
                  //   vendor['name'].substring(0, 1),
                  //   style: const TextStyle(fontSize: 24, color: Colors.white),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClothesVendorList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3, // Example: 3 vendor cards
      itemBuilder: (context, index) {
        // Different clothes vendors
        final List<Map<String, dynamic>> clothesVendors = [
          {
            'name': 'Trendy Threads',
            'categories': ['Shirts', 'Dresses'],
            'rating': 5,
            'image': 'assets/trendy.png',
          },
          {
            'name': 'Island Style Boutique',
            'categories': ['Traditional', 'Casual'],
            'rating': 4,
            'image': 'assets/island.png',
          },
          {
            'name': 'Fashion Forward',
            'categories': ['Accessories', 'Footwear'],
            'rating': 4,
            'image': 'assets/fashion.png',
          },
        ];

        final vendor = clothesVendors[index];

        return Card(
          color: Colors.blue[50],
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
                        vendor['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var category in vendor['categories'])
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.blue[100],
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(category),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var i = 0; i < vendor['rating']; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          for (var i = vendor['rating']; i < 5; i++)
                            const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Visit Page',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.blue[200],
                  backgroundImage: AssetImage(vendor['image']),
                  // child: Text(
                  //   vendor['name'].substring(0, 1),
                  //   style: const TextStyle(fontSize: 24, color: Colors.white),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandcraftsVendorList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3, // Example: 3 vendor cards
      itemBuilder: (context, index) {
        // Different handcrafts vendors
        final List<Map<String, dynamic>> handcraftsVendors = [
          {
            'name': 'Creative Crafts',
            'categories': ['Pottery', 'Sculptures'],
            'rating': 5,
            'image': 'assets/creative.png',
          },
          {
            'name': 'Handmade Haven',
            'categories': ['Jewelry', 'Accessories'],
            'rating': 4,
            'image': 'assets/handmade.png',
          },
          {
            'name': 'Artisanal Treasures',
            'categories': ['Home Decor', 'Wall Art'],
            'rating': 5,
            'image': 'assets/artisanal.png',
          },
        ];

        final vendor = handcraftsVendors[index];

        return Card(
          color: Colors.orange[50],
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
                        vendor['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var category in vendor['categories'])
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.orange[100],
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(category),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var i = 0; i < vendor['rating']; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          for (var i = vendor['rating']; i < 5; i++)
                            const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Visit Page',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.orange[200],
                  backgroundImage: AssetImage(vendor['image']),
                  // child: Text(
                  //   vendor['name'].substring(0, 1),
                  //   style: const TextStyle(fontSize: 24, color: Colors.white),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiscellaneousVendorList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3, // Example: 3 vendor cards
      itemBuilder: (context, index) {
        // Different miscellaneous vendors
        final List<Map<String, dynamic>> miscVendors = [
          {
            'name': 'Gadget Galaxy',
            'categories': ['Electronics', 'Repairs'],
            'rating': 4,
            'image': 'assets/gadget.png',
          },
          {
            'name': 'Green Thumb Gardens',
            'categories': ['Plants', 'Garden Tools'],
            'rating': 5,
            'image': 'assets/green.png',
          },
          {
            'name': 'Wellness World',
            'categories': ['Beauty', 'Health'],
            'rating': 4,
            'image': 'assets/wellness.png',
          },
        ];

        final vendor = miscVendors[index];

        return Card(
          color: Colors.purple[50],
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
                        vendor['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var category in vendor['categories'])
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.purple[100],
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(category),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var i = 0; i < vendor['rating']; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          for (var i = vendor['rating']; i < 5; i++)
                            const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Visit Page',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.purple[200],
                  backgroundImage: AssetImage(vendor['image']),
                  // child: Text(
                  //   vendor['name'].substring(0, 1),
                  //   style: const TextStyle(fontSize: 24, color: Colors.white),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

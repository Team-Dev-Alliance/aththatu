import 'package:flutter/material.dart';
import '../components/profile_header.dart';
import '../components/profie_tab_bar.dart';
import 'user_settings_tab.dart';
import 'notifications_tab.dart';
import 'wishlist_tab.dart';
import 'orders_tab.dart';
import 'wallet_tab.dart';
import '../components/title_bar.dart';
import '../components/navigation_bar.dart' as nav;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentNavIndex = 3; // Profile tab selected

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            }else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/categories');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/cart');
            } else if (index == 3) {
              // Already on Profile page, do nothing
            }
            // Handle other navigation logic
          });
        },
      ),
      body: Column(
        children: [
          const ProfileHeader(userName: 'Tekashi 6ix9ine'),
          ProfileTabBar(controller: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                UserSettingsTab(),
                NotificationsTab(),
                WishlistTab(),
                OrdersTab(),
                WalletTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
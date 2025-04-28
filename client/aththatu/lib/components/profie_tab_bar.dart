import 'package:flutter/material.dart';

class ProfileTabBar extends StatelessWidget {
  final TabController controller;

  const ProfileTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.transparent,
      tabs: [
        _buildTab('User Settings', Icons.settings),
        _buildTab('Notifications', Icons.notifications),
        _buildTab('My Wishlist', Icons.favorite_border),
        _buildTab('My Orders', Icons.receipt),
        // _buildTab('Wallet', Icons.account_balance_wallet),
      ],
    );
  }

  Widget _buildTab(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
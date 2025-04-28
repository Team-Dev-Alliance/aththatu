import 'package:flutter/material.dart';
import '../components/seller_navigation_bar.dart' as nav;
import '../components/profile_header.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  int _currentNavIndex = 3; // Profile tab selected

  String description = "High-quality clay pots handcrafted with love.";
  List<String> phoneNumbers = ["+1 123 456 7890"];
  String bannerImageUrl = ""; // Empty for now
  String profileImageUrl = ""; // Empty for now

  void _onNavBarTap(int index) {
    setState(() {
      _currentNavIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/seller_home');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/seller_products');
      } else if (index == 3) {
        // Already on profile
      }
    });
  }

  void _editDescription() async {
    final controller = TextEditingController(text: description);
    final newDescription = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Description"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(labelText: "Store Description"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (newDescription != null && newDescription.isNotEmpty) {
      setState(() {
        description = newDescription;
      });
    }
  }

  void _addPhoneNumber() async {
    final controller = TextEditingController();
    final newPhone = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Phone Number"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: "Phone Number"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Add"),
          ),
        ],
      ),
    );

    if (newPhone != null && newPhone.isNotEmpty) {
      setState(() {
        phoneNumbers.add(newPhone);
      });
    }
  }

  void _changeBannerPicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Change banner picture (not implemented)")),
    );
    // TODO: Add image picker
  }

  void _changeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Change profile picture (not implemented)")),
    );
    // TODO: Add image picker
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/seller_home'),
        ),
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            GestureDetector(
              onTap: _changeProfilePicture,
              child: const ProfileHeader(userName: 'CHATHU CLAY POTS'),
            ),
            const SizedBox(height: 8),
            // Banner Image
            GestureDetector(
              onTap: _changeBannerPicture,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  image: bannerImageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(bannerImageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: bannerImageUrl.isEmpty
                    ? const Center(child: Icon(Icons.photo, size: 50))
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            ListTile(
              title: const Text("Store Description"),
              subtitle: Text(description),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _editDescription,
              ),
            ),
            const Divider(),
            // Phone Numbers
            ListTile(
              title: const Text("Phone Numbers"),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addPhoneNumber,
              ),
            ),
            ...phoneNumbers.map(
              (phone) => ListTile(
                leading: const Icon(Icons.phone),
                title: Text(phone),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: nav.NavigationBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

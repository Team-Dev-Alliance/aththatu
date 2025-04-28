import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Cart/cart_provider.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        NotificationBell(),
        CartIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CartIcon extends StatefulWidget {
  const CartIcon({super.key});

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  final GlobalKey _cartKey = GlobalKey();
  bool _showCartMenu = false;

  void _toggleCartMenu() {
    setState(() {
      _showCartMenu = !_showCartMenu;
    });
    
    if (_showCartMenu) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final cartItems = cartProvider.cartItems;
      
      // Show the popup
      final RenderBox renderBox = _cartKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      
      showMenu(
        context: context,
        color: Colors.white,
        position: RelativeRect.fromLTRB(
          position.dx,
          position.dy + renderBox.size.height,
          position.dx + renderBox.size.width,
          position.dy + renderBox.size.height,
        ),
        items: [
          PopupMenuItem(
            enabled: false,
            padding: EdgeInsets.zero,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              constraints: BoxConstraints(
                minWidth: 300,
                maxWidth: 400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/cart');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                          ),
                          child: const Text(
                            'View Cart',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      maxHeight: 300,
                    ),
                    child: cartItems.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartItems.length > 3 ? 3 : cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _buildCartItem(item);
                            },
                          ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (cartItems.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal:'),
                                Text(
                                  'Rs. ${cartProvider.calculateSubtotal().toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ElevatedButton(
                          onPressed: cartItems.isEmpty
                              ? null
                              : () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, '/cart');
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: const Size.fromHeight(40),
                          ),
                          child: const Text('Checkout'),
                        ),
                        if (cartItems.length > 3)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/cart');
                              },
                              child: Text(
                                'See all ${cartItems.length} items',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        elevation: 8.0,
      ).then((value) {
        setState(() {
          _showCartMenu = false;
        });
      });
    }
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/cart');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['productName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item['shopName'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs. ${item['unitPrice']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Qty: ${item['quantity']}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the cart item count from CartProvider
    final cartProvider = context.watch<CartProvider>();
    final cartItemCount = cartProvider.cartItems.length;
    
    return IconButton(
      key: _cartKey,
      icon: Stack(
        children: [
          const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          if (cartItemCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  cartItemCount > 9 ? '9+' : '$cartItemCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onPressed: _toggleCartMenu,
    );
  }
}

class NotificationBell extends StatefulWidget {
  @override
  _NotificationBellState createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final GlobalKey _notificationKey = GlobalKey();
  bool _showNotifications = false;
  
  // Sample notifications - in real app, these would come from a service
  final List<NotificationItem> notifications = [
    NotificationItem("Order #12345 has been shipped!", false),
    NotificationItem("Flash Sale! 50% off on electronics", false),
    NotificationItem("Your wishlist item is back in stock", true),
    NotificationItem("Delivery scheduled for tomorrow", false),
  ];

  void _toggleNotificationMenu() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
    
    if (_showNotifications) {
      // Show the popup
      final RenderBox renderBox = _notificationKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      
      showMenu(
        context: context,
        color: Colors.white,
        position: RelativeRect.fromLTRB(
          position.dx,
          position.dy + renderBox.size.height,
          position.dx + renderBox.size.width,
          position.dy + renderBox.size.height,
        ),
        items: [
          PopupMenuItem(
            enabled: false,
            padding: EdgeInsets.zero,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              constraints: BoxConstraints(
                minWidth: 300,
                maxWidth: 400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Notifications',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Mark all as read logic
                            setState(() {
                              for (var notification in notifications) {
                                notification.read = true;
                              }
                            });
                            Navigator.pop(context);
                            _toggleNotificationMenu();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'Mark all as read',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: notifications.map((notification) => _buildNotificationItem(notification)).toList(),
                    ),
                  ),
                  if (notifications.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No notifications',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  const Divider(height: 1, thickness: 1),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context, 
                            '/profile',
                            arguments: {'initialTab': 1}
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'See all notifications',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        elevation: 8.0,
      ).then((value) {
        setState(() {
          _showNotifications = false;
        });
      });
    }
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Handle notification tap
          setState(() {
            notification.read = true;
          });
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                notification.read ? Icons.notifications_none : Icons.notifications_active,
                color: notification.read ? Colors.grey : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  notification.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: notification.read ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (!notification.read)
                IconButton(
                  icon: const Icon(Icons.circle, size: 12, color: Colors.orange),
                  onPressed: () {
                    setState(() {
                      notification.read = true;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: _notificationKey,
      icon: Stack(
        children: [
          const Icon(Icons.notifications_none, color: Colors.black),
          if (notifications.any((notification) => !notification.read))
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '${notifications.where((notification) => !notification.read).length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onPressed: _toggleNotificationMenu,
    );
  }
}

class NotificationItem {
  String title;
  bool read;

  NotificationItem(this.title, this.read);
}
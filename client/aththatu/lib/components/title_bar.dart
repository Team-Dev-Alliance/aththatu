import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        NotificationBell(),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {
            // Navigate to cart
            Navigator.pushReplacementNamed(context, '/cart');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
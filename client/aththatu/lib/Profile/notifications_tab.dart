import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<NotificationItem> notifications = [
    NotificationItem("Order #12345 has been shipped!", false),
    NotificationItem("Flash Sale! 50% off on electronics", false),
    NotificationItem("Your wishlist item is back in stock", true),
    NotificationItem("Delivery scheduled for tomorrow", false),
  ];

  void markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n.read = true;
      }
    });
  }

  void markAsRead(int index) {
    setState(() {
      notifications[index].read = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: markAllAsRead,
            child: const Text(
              "Mark all as read",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: Icon(
              item.read ? Icons.notifications_none : Icons.notifications_active,
              color: item.read ? Colors.grey : Colors.blue,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                fontWeight: item.read ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            trailing: !item.read
                ? TextButton(
                    onPressed: () => markAsRead(index),
                    child: const Text("Mark as read"),
                  )
                : null,
          );
        },
      ),
    );
  }
}

class NotificationItem {
  String title;
  bool read;

  NotificationItem(this.title, this.read);
}
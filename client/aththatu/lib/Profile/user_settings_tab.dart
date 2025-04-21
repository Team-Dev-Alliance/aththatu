import 'package:flutter/material.dart';

class UserSettingsTab extends StatefulWidget {
  const UserSettingsTab({super.key});

  @override
  State<UserSettingsTab> createState() => _UserSettingsTabState();
}

class _UserSettingsTabState extends State<UserSettingsTab> {
  String userName = "Tekashi 6ix9ine";
  List<String> emails = ["tekashi@example.com"];
  List<String> phoneNumbers = ["+1 123 456 7890"];
  List<String> addresses = ["123 Main Street, Brooklyn, NY"];

  void _editName() async {
    final controller = TextEditingController(text: userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Save"))
        ],
      ),
    );

    if (newName != null && newName.trim().isNotEmpty) {
      setState(() {
        userName = newName.trim();
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Add"))
        ],
      ),
    );

    if (newPhone != null && newPhone.trim().isNotEmpty) {
      setState(() {
        phoneNumbers.add(newPhone.trim());
      });
    }
  }

  void _addAddress() async {
    final controller = TextEditingController();
    final newAddress = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Address"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Address"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Add"))
        ],
      ),
    );

    if (newAddress != null && newAddress.trim().isNotEmpty) {
      setState(() {
        addresses.add(newAddress.trim());
      });
    }
  }

  void _addEmail() async {
    final controller = TextEditingController();
    final newEmail = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Email"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Add"))
        ],
      ),
    );

    if (newEmail != null && newEmail.trim().isNotEmpty) {
      setState(() {
        emails.add(newEmail.trim());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          title: Text(userName),
          subtitle: const Text("Name"),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editName,
          ),
        ),
        ListTile(
          title: const Text("Emails"),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addEmail,
          ),
        ),
        ...emails.map((email) => ListTile(
              title: Text(email),
              leading: const Icon(Icons.email),
            )),
        const Divider(),
        ListTile(
          title: const Text("Phone Numbers"),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addPhoneNumber,
          ),
        ),
        ...phoneNumbers.map((phone) => ListTile(
              title: Text(phone),
              leading: const Icon(Icons.phone),
            )),
        const Divider(),
        ListTile(
          title: const Text("Addresses"),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addAddress,
          ),
        ),
        ...addresses.map((addr) => ListTile(
              title: Text(addr),
              leading: const Icon(Icons.home),
            )),
      ],
    );
  }
}

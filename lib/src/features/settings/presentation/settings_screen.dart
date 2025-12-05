import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              trailing: Switch(value: isDarkMode, onChanged: (value) {}),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Erinnerungen"),
              subtitle: const Text("Vor Terminen benachrichtigen"),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() => notificationsEnabled = value);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text("Tiere verwalten"),
              onTap: () {
                Navigator.pushNamed(context, '/manage_pets');
              },
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Über diese App"),
              subtitle: Text("Version 1.0.0"),
            ),
          ],
        ),
      ),
    );
  }
}

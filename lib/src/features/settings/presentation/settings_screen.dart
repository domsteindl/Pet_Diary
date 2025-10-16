import 'package:flutter/material.dart';
import 'package:pet_diary/main.dart';

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
      appBar: AppBar(title: Text("Einstellungen")),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = !isDarkMode;
                    MainApp.of(
                      context,
                    )?.changeTheme(isDarkMode ? ThemeMode.dark : ThemeMode.light);
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Erinnerungen"),
              subtitle: Text("Vor Terminen benachrichtigen"),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() => notificationsEnabled = value);
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text("Tiere verwalten"),
              onTap: () {
                Navigator.pushNamed(context, '/manage_pets');
              },
            ),
            Divider(),
            ListTile(
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

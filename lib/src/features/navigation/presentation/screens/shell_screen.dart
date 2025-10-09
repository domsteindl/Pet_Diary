import 'package:flutter/material.dart';
import 'package:pet_diary/src/features/appointments/presentation/screens/pet_appointments.dart';
import 'package:pet_diary/src/features/home/presentation/screens/home_screen.dart';
import 'package:pet_diary/src/features/pet_profile/presentation/screens/pet_profile_screen.dart';
import 'package:pet_diary/src/features/settings/presentation/settings_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    PetAppointmentScreen(),
    PetProfileScreen(),
    SettingsScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Tiertagebuch")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Dominik Steindl"),
              accountEmail: Text("Email"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/200"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              onTap: () => setState(() {
                index = 0;
              }),
            ),
            ListTile(
              leading: Icon(Icons.edit_calendar_outlined),
              title: Text("Appointments"),
              onTap: () => setState(() {
                index = 1;
              }),
            ),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text("My Pet"),
              onTap: () => setState(() {
                index = 2;
              }),
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text("Settings"),
              onTap: () => setState(() {
                index = 3;
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          index = value;
        }),
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_outlined),
            label: "Termine",
            activeIcon: Icon(Icons.edit_calendar),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Meine Tiere"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Einstellungen",
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),

      body: IndexedStack(index: index, children: screens),
    );
  }
}

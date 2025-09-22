import 'package:flutter/material.dart';
import 'package:pet_diary/features/appointments/presentation/pet_appointments.dart';
import 'package:pet_diary/features/home/presentation/home_screen.dart';
import 'package:pet_diary/features/pet_profile/presentation/pet_profile_screen.dart';
import 'package:pet_diary/features/settings/presentation/settings_screen.dart';

class ShellScreen extends StatefulWidget {
  
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  final List<Widget> screens = [HomeScreen(), PetAppointment(), PetProfileScreen(), SettingsScreen()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          index = value;
        }),
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home", activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_outlined),
            label: "Termine",
            activeIcon: Icon(Icons.edit_calendar)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Meine Tiere"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Einstellungen",
            activeIcon: Icon(Icons.settings)
          ),
        ],
      ),
    
      body: IndexedStack(
        index: index,
        children: screens
      ),
    );
  }
}

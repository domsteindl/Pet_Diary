import 'package:flutter/material.dart';
import 'package:pet_diary/features/home/widgets/pet_carousel_widget.dart';
import 'package:pet_diary/features/home/widgets/pet_stats_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar),
            label: "Termine",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Meine Tiere"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Einstellungen",
          ),
        ],
      ),
      appBar: AppBar(title: Text("Tiertagebuch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PetCarouselWidget(),
            PetStatsCard(),
            BottomAppBar(child: Text("Thank you for using my App!")),
          ],
        ),
      ),
    );
  }
}

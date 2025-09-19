import 'package:flutter/material.dart';
import 'package:pet_diary/features/home/widgets/pet_carousel_widget.dart';
import 'package:pet_diary/features/home/widgets/pet_stats_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tiertagebuch")),
      body: Center(
        child: Column(
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
import 'package:flutter/material.dart';
import 'package:pet_diary/features/home/widgets/pet_carousel_widget.dart';
import 'package:pet_diary/features/home/widgets/pet_stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PetCarouselWidget(),
          PetStatsCard(),
          BottomAppBar(child: Text("Thank you for using my App!")),
        ],
      ),
    );
  }
}

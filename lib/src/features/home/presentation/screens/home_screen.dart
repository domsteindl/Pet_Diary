import 'package:flutter/material.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_carousel_widget.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
            PetCarouselWidget(),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(child: Text("Thank you for using my App!")),
            ),
          ],
        ),
    );
  }
}

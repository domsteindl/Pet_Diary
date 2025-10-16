import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_diary_entry.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_quick_action_button.dart';
import '../widgets/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = PetManager.instance.pets;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Tiertagebuch")),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: pets.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) => PetCard(pet: pets[index]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text("Heutiges Tagebuch"),
            ),
            DiaryEntryCard(
              title: "Entry Placeholder",
              pet: pets[0],
              text1: "Text1",
              text2: "Text2",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text("Schnellaktionen"),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      QuickActionButton(label: "Tier anlegen"),
                      const SizedBox(width: 10),
                      QuickActionButton(label: "Termin erstellen"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      QuickActionButton(label: "Tagebucheintrag"),
                      const SizedBox(width: 10),
                      QuickActionButton(label: "Test"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_card.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/main_screen/pet_sticky_header.dart';

class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = PetManager.instance.pets;

  MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/manage_pets'),
          heroTag: null,
          child: Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(title: const Text("Tiertagebuch")),

            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Meine Haustiere",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return PetCard(pet: pets[index]);
                }, childCount: pets.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

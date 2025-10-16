import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/main_screen/pet_card.dart';

class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = PetManager.instance.pets;

  MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/manage_pets'),
        heroTag: null,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(title: Text("Meine Haustiere")),
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
                  return PetCard(pet: pets[index], index: index);
                }, childCount: pets.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

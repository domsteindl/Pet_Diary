import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/main_screen/pet_card.dart';

class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = PetManager.instance.pets;

  MyPetsScreen({super.key});

  void _goToManagePets(BuildContext context, [Pet? pet]) {
    Navigator.pushNamed(
      context,
      '/manage_pets',
      arguments: pet, // null if adding new, or pass the pet for editing
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _goToManagePets(context),
        icon: Icon(Icons.manage_accounts),
        label: Text('Verwalten'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        heroTag: null,
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 80,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              elevation: 3,

              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Meine Haustiere",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),

            // Grid of pets
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
                  final pet = pets[index];
                  return GestureDetector(
                    onLongPress: () => _goToManagePets(context, pet),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PetCard(pet: pet, index: index),
                      ),
                    ),
                  );
                }, childCount: pets.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

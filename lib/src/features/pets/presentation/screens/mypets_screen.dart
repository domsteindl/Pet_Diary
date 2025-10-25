import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/main_screen/pet_card.dart';

class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = PetManager().pets;

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
      appBar: AppBar(
        title: Text(
          "Tiertagebuch",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 3,
      ),

      body: SafeArea(child: Text("")),
    );
  }
}

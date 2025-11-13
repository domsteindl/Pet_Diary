import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/hive_service.dart';


class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = HiveService.getAllPets();

  MyPetsScreen({super.key});



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

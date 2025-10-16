import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class TabContentBasic extends StatelessWidget {
  final Pet pet;

  const TabContentBasic({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: ${pet.name}"),
        Text("Art: ${pet.species.label}"),
        Text("Alter: ${pet.age}"),
        Text("Gewicht: ${pet.weight}kg"),
      ],
    );
  }
}

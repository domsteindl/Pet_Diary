import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/mypets_details_screen.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final int index;

  const PetCard({super.key, required this.pet, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MyPetsDetailsScreen(pet: pet, index: index),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Hero(
                tag: 'tag_$index',
                child: Image.network(pet.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                pet.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FittedBox(
                child: Row(
                  children: [
                    Text(
                      pet.species.label,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        '•',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Text(
                      '${pet.age}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        '•',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Text(
                      '${pet.weight}kg',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(pet.description),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_diary/core/enums/pet_type.dart';
import 'package:pet_diary/core/models/pet.dart';

class PetCarouselItem extends StatelessWidget {
  final Pet pet;
  const PetCarouselItem({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: Image.network(
                  pet.imageUrl,
                  width: 160,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('${pet.age} Jahre alt'),
                    SizedBox(height: 12),
                    Text('Typ: ${pet.species.label}', style: TextStyle(color: Colors.grey[700]),),
                  ],
                ),
              ),
            ],
          ),
        ),

        /*
            Image.network(
              pet.imageUrl,
            ),
            SizedBox(height: 16),
            Text('${pet.species.name} ${pet.id + 1}'),
            */
      ),
    );
  }
}

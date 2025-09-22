import 'package:pet_diary/core/enums/pet_type.dart';

class Pet {
  final String id;
  final String name;
  final PetType species;
  final int age;
  final String imageUrl;
  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
  });
}

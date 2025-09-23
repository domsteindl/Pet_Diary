import 'package:pet_diary/core/enums/pet_type.dart';

class Pet {
  static int _idCounter = 0;
  final int id;
  final String name;
  final PetType species;
  final int age;
  final String imageUrl;
  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
  }) : id = _idCounter++;
}

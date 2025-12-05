import 'package:pet_diary/src/core/enums/habitat_type.dart';
import 'package:pet_diary/src/core/models/pet.dart';

abstract class Habitat {
  final double length;
  final double height;
  final double width;
  final int numberOfPets;
  final List<Pet> pets;
  final HabitatType type;
  Habitat({
    required this.length,
    required this.height,
    required this.width,
    List<Pet>? pets,
    required this.type,
  }) : pets = pets ?? [],
       numberOfPets = 0;

  void addPet(Pet pet) {
    //TODO Datenbankaufruf
    pets.add(pet);
  }
}

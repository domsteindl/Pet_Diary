import 'package:pet_diary/core/models/pet.dart';

class PetManager {

  PetManager._privateConstructor();

  static final PetManager instance = PetManager._privateConstructor();

  final List<Pet> _pets = [];

  List<Pet> get pets => List.unmodifiable(_pets);
  int get numberOfPets => _pets.length;

  void addPet(Pet pet) {
    pets.add(pet);
  }

    void removePet(Pet pet) {
    pets.remove(pet);
  }
    void updatePet(Pet pet) {
    
  }

    void clearPet(Pet pet) {
    _pets.clear();
  }
}
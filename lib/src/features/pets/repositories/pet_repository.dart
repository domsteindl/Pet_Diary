import 'package:pet_diary/src/core/models/pet.dart';

abstract class PetRepository {  
  Future<List<Pet>> getAllPets();
  Future<void> addPet(Pet pet);
  Future<void> updatePet(Pet pet);
  Future<void> deletePet(String id);
}

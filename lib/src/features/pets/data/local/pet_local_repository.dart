import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/features/pets/repositories/pet_repository.dart';

class PetLocalRepository implements PetRepository {
  final Box<Pet> _box;

  PetLocalRepository(this._box);

  @override
  Future<List<Pet>> getAllPets() async => _box.values.toList();

  @override
  Future<void> addPet(Pet pet) async => _box.put(pet.id, pet);

  @override
  Future<void> updatePet(Pet pet) async => _box.put(pet.id, pet);

  @override
  Future<void> deletePet(String id) async => _box.delete(id);
}

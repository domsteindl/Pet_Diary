import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/features/pets/repositories/pet_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class PetRemoteRepository implements PetRepository {
  final SupabaseClient client;

  PetRemoteRepository(this.client);

  @override
  Future<List<Pet>> getAllPets() async {
    final response = await client.from('pets').select();
    return (response as List).map((data) => Pet.fromMap(data)).toList();
  }

  @override
  Future<void> addPet(Pet pet) async {
    await client.from('pets').insert(pet.toMap());
  }

  @override
  Future<void> updatePet(Pet pet) async {
    await client.from('pets').update(pet.toMap()).eq('id', pet.id);
  }

  @override
  Future<void> deletePet(String id) async {
    await client.from('pets').delete().eq('id', id);
  }
}

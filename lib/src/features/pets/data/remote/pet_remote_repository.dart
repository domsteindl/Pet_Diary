import 'package:pet_diary/src/core/models/appointment.dart';
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

  Future<bool> exists(int? id) async {
    if (id == null) return false;

    final data = await client
        .from('pets')
        .select('id')
        .eq('id', id)
        .limit(1)
        .maybeSingle();

    final exists = data != null;

    return exists;
  }

  @override
  Future<int> addPet(Pet pet) async {
    final response = await client
        .from('pets')
        .insert({
          'name': pet.name,
          'species': pet.species.name,
          'age': pet.age,
          'weight': pet.weight,
          'image_url': pet.imageUrl,
          'description': pet.description,
          // 'user_id' : SupabaseService.client.auth.currentUser!.id,
        })
        .select()
        .single();
    pet.setId(response['id']);
    return response['id'];
  }

  @override
Future<void> updatePet(Pet pet) async {
    final petId = pet.id;
    if (petId == null) throw Exception('Cannot update pet without ID');

    await client
        .from('pets')
        .update({
          'name': pet.name,
          'species': pet.species.name,
          'age': pet.age,
          'weight': pet.weight,
          'image_url': pet.imageUrl,
          'description': pet.description,
        })
        .eq('id', petId);
  }

  @override
  Future<void> deletePet(int id) async {
    await client.from('pets').delete().eq('id', id);
  }

  Future<void> addAppointment({
    required int petId,
    required PetAppointment appointment,
  }) async {
    await client.from('pet_appointments').insert({
      'pet_id': petId,
      'date': appointment.date.toIso8601String(),
      'description': appointment.description,
      'type': appointment.type.name,
    });
  }
}

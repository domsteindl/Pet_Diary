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

    for (var petData in response) {
      final diaryData = await client
          .from('diary_entries')
          .select()
          .eq('pet_id', petData['id']);

      petData['entries'] = diaryData;
    }

    return (response as List).map((data) => Pet.fromMap(data)).toList();
  }

  Future<Pet> getPetById(int id) async {
    final petData = await client.from('pets').select().eq('id', id).single();

    final diaryData = await client
        .from('diary_entries')
        .select()
        .eq('pet_id', id);

    petData['entries'] = diaryData;
    return Pet.fromMap(petData);
  }

  Future<bool> exists(int id) async {
    final response = await client
        .from('pets')
        .select('id')
        .eq('id', id)
        .maybeSingle();

    return response != null;
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

  Future<void> addDiaryEntry(
    int petId,
    String type,
    String? description,
    String? note,
    Map<dynamic, dynamic>? customFields,
  ) async {
    await client.from('diary_entries').insert({
      'pet_id': petId,
      'date': DateTime.now(),
      'type': type,
      'description': description ?? 'Platzhalterbeschreibung',
      'note': note ?? 'Platzhalternotiz',
      'custom_fields': customFields ?? '',
    });
  }
}

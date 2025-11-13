import 'package:pet_diary/src/features/pets/data/local/pet_local_repository.dart';
import 'package:pet_diary/src/features/pets/data/remote/pet_remote_repository.dart';

class PetSyncService {
  final PetLocalRepository localRepo;
  final PetRemoteRepository remoteRepo;

  PetSyncService({required this.localRepo, required this.remoteRepo});

  Future<void> pushLocalChanges() async {
    final localPets = await localRepo.getAllPets();

    for (final pet in localPets) {
      if (pet.id == null) {
        // Neues Pet → in Supabase anlegen
        final newId = await remoteRepo.addPet(pet);
        pet.setId(newId); // lokale Pet-ID mit Supabase-ID setzen
        await localRepo.updatePet(pet);
      } else {
        // Existierendes Pet → nur updaten
        await remoteRepo.updatePet(pet);
      }

      // Termine syncen
      for (final appointment in pet.appointments) {
        await remoteRepo.addAppointment(
          petId: pet.id!,
          appointment: appointment,
        );
      }
    }
  }

  Future<void> pullRemoteChanges() async {
    final remotePets = await remoteRepo.getAllPets();
    final localPets = await localRepo.getAllPets();

    for (final pet in remotePets) {
      final existsLocally = localPets.any((p) => p.id == pet.id);
      if (!existsLocally) {
        await localRepo.addPet(pet);
      }
    }
  }

  Future<void> syncAll() async {
    await pullRemoteChanges();
    await pushLocalChanges();
  }
}

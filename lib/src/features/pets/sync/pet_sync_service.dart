

import 'package:pet_diary/src/features/pets/data/local/pet_local_repository.dart';
import 'package:pet_diary/src/features/pets/data/remote/pet_remote_repository.dart';

class PetSyncService {
  final PetLocalRepository localRepo;
  final PetRemoteRepository remoteRepo;

  PetSyncService({required this.localRepo, required this.remoteRepo});

  /// Sync von lokal nach Supabase
  Future<void> pushLocalChanges() async {
    final localPets = await localRepo.getAllPets();
    for (final pet in localPets) {
      // Beispiel: prüfe, ob der Datensatz noch nicht auf Supabase existiert
      await remoteRepo.addPet(pet);
    }
  }

  /// Sync von Supabase nach lokal
  Future<void> pullRemoteChanges() async {
    final remotePets = await remoteRepo.getAllPets();
    for (final pet in remotePets) {
      await localRepo.addPet(pet);
    }
  }

  /// Gesamter Sync-Vorgang
  Future<void> syncAll() async {
    await pullRemoteChanges();
    await pushLocalChanges();
  }
}

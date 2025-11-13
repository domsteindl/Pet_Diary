

import 'package:pet_diary/src/features/pets/sync/pet_sync_service.dart';

class SyncPetsUseCase {
  final PetSyncService syncService;

  SyncPetsUseCase(this.syncService);

  Future<void> call() async {
    await syncService.syncAll();
  }
}

import 'package:pet_diary/src/features/pets/data/local/pet_local_repository.dart';
import 'package:pet_diary/src/features/pets/data/remote/pet_remote_repository.dart';
import 'package:pet_diary/src/features/pets/sync/pet_sync_service.dart';

import 'hive_service.dart';
import 'supabase_service.dart';

class Services {
  static late final PetSyncService syncService;

  static late final PetLocalRepository localRepo;
  static late final PetRemoteRepository remoteRepo;
  static Future<void> initAll() async {
    await HiveService.init();
    await SupabaseService.init();

    localRepo = PetLocalRepository(HiveService.petBox);
    remoteRepo = PetRemoteRepository(SupabaseService.client);

    syncService = PetSyncService(localRepo: localRepo, remoteRepo: remoteRepo);
  }

  static Future<void> syncAll() async {
   await syncService.syncAll();
  }
}

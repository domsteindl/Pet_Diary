
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/hive/hive_adapters.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Adapter registrieren
    Hive.registerAdapter(PetTypeAdapter());
    Hive.registerAdapter(PetAppointmentAdapter());
    Hive.registerAdapter(DiaryEntryAdapter());

    // Boxen öffnen
    await Hive.openBox('pets');
    await Hive.openBox('diaryEntries');
  }
}

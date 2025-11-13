
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/hive/hive_adapters.dart';
import 'package:pet_diary/hive/hive_registrar.g.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class HiveService {
   static late Box<Pet> _petBox;
  static Future<void> init() async {
    await Hive.initFlutter();

    // Adapter registrieren
/*     Hive.registerAdapter(PetTypeAdapter());
    Hive.registerAdapter(PetAppointmentAdapter());
    Hive.registerAdapter(DiaryEntryAdapter()); */
    Hive.registerAdapters();

    // Boxen öffnen
_petBox = await Hive.openBox<Pet>('pets');
  //  await Hive.openBox('diaryEntries');
  }

    static List<Pet> getAllPets() => _petBox.values.toList();

  static Future<void> addPet(Pet pet) async => await _petBox.add(pet);

  static Future<void> updatePet(int key, Pet pet) async => await _petBox.put(key, pet);
   static Box<Pet> get petBox => _petBox;
}

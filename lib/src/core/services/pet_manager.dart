import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/hive/hive_registrar.g.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/enums/entry_type.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/models/appointment.dart';

import 'package:pet_diary/src/core/models/entry.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class PetManager {
  // PetManager._privateConstructor();

  // static final PetManager instance = PetManager._privateConstructor();
  // final petsHive = Hive.box<Pet>(petBox).values;

  static final PetManager _instance = PetManager._internal();
  factory PetManager() => _instance;
  PetManager._internal();

  late Box<Cat> _petBox;

  Future<void> init() async {
    // Hive initialisieren (nur einmal, am Anfang)
    await Hive.initFlutter();

    // Adapter registrieren
    Hive.registerAdapters();

    // Box öffnen
    _petBox = await Hive.openBox<Cat>('pet_box');

    // Start-Daten nur einmal füllen

    if (_petBox.isEmpty) {
      await _petBox.addAll(_pets.cast<Cat>());
    }
  }

  final List<Cat> _pets = [
    Cat(
      name: "Luna",
      species: PetType.cat,
      age: 24,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      appointments: [
        PetAppointment(
          date: DateTime(2025, DateTime.october, 17, 17),
          description: "Entläusen",
          type: AppointmentType.pflege,
        ),
        PetAppointment(
          date: DateTime(2025, DateTime.october, 10, 18, 2),
          description: "Haare Schneiden",
          type: AppointmentType.friseur,
        ),

        PetAppointment(
          date: DateTime(2025, DateTime.september, 28),
          description: "Waschen",
          type: AppointmentType.pflege,
        ),
      ],
      entries: [
        DiaryEntry(
          date: DateTime(2025, 10, 14, 9, 30),
          type: EntryType.food,
          description: "Frühstück: Trockenfutter und Wasser",
          note: "Hat alles aufgegessen",
        ),
        DiaryEntry(
          date: DateTime(2025, 10, 14, 15, 0),
          type: EntryType.activity,
          description: "Spaziergang im Park",
          note: "War sehr aufgeregt, viel gerannt",
        ),
        DiaryEntry(
          date: DateTime(2025, 10, 13, 18, 0),
          type: EntryType.health,
          description: "Tierarzt: Impfkontrolle",
          note: "Alles in Ordnung, keine Auffälligkeiten",
        ),
        DiaryEntry(
          date: DateTime(2025, 10, 12, 20, 0),
          type: EntryType.note,
          description: "Neue Spielzeuge ausprobiert",
          note: "Hat besonders die kleine Maus gemocht",
          customFields: {"mood": "happy", "energyLevel": 8},
        ),
      ],
    ),
    Cat(
      name: "Mark",
      species: PetType.cat,
      age: 22,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      appointments: [
        PetAppointment(
          date: DateTime(2025, DateTime.october, 13, 17),
          description: "Entläusen",
          type: AppointmentType.pflege,
        ),
      ],
    ),
    // Dog(
    //   name: "Sebastian",
    //   species: PetType.dog,
    //   age: 18,
    //   imageUrl:
    //       "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    //   description: "Verschmusst, liebt Eiscreme und Katzenminze",
    // ),
    // Dog(
    //   name: "Sebastian",
    //   species: PetType.dog,
    //   age: 18,
    //   imageUrl:
    //       "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    //   description: "Verschmusst, liebt Eiscreme und Katzenminze",
    //   appointments: [
    //     PetAppointment(
    //       date: DateTime(2025, DateTime.october, 14),
    //       description: "Waschen",
    //       type: AppointmentType.pflege,
    //     ),
    //   ],
    // ),
    // Dog(
    //   name: "Sebastian",
    //   species: PetType.dog,
    //   age: 18,
    //   imageUrl:
    //       "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    //   description: "Verschmusst, liebt Eiscreme und Katzenminze",
    // ),
    // Dog(
    //   name: "Sebastian",
    //   species: PetType.dog,
    //   age: 18,
    //   imageUrl:
    //       "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    //   description: "Verschmusst, liebt Eiscreme und Katzenminze",
    // ),
  ];

  // List<Pet> get pets => List.unmodifiable(_pets);
  int get numberOfPets => _pets.length;

  // void addPet(Pet pet) {
  //   _pets.add(pet);
  // }

  // void removePet(Pet pet) {
  //   _pets.remove(pet);
  // }

  // void updatePet(Pet pet) {}

  // void clearPet(Pet pet) {
  //   _pets.clear();
  // }

  void addEntry(Pet pet, DiaryEntry entry) {
    pet.entries.add(entry);
  }

  void addAppointment(Pet pet, PetAppointment appointment) {
    pet.appointments.add(appointment);
  }

  // Zugriff auf alle Pets
  List<Pet> get pets => _petBox.values.toList();

  // ValueListenable für Widgets
  ValueListenable<Box<Pet>> get listenable => _petBox.listenable();

  //Future<void> clearPetList() async => await

  Future<void> addPet(Cat pet) async => await _petBox.put(pet.id, pet);

  Future<void> deletePet(int key) async => await _petBox.delete(key);

  Future<void> updatePet(int key, Cat pet) async => await _petBox.put(key, pet);

  Cat? getPet(int key) => _petBox.get(key);

  Future<void> emptyList() async => await _petBox.clear();
}

import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/enums/entry_type.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/Cat.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/dog.dart';
import 'package:pet_diary/src/core/models/entry.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class PetManager {
  PetManager._privateConstructor();

  static final PetManager instance = PetManager._privateConstructor();

  final List<Pet> _pets = [
    Cat(
      name: "Luna",
      species: PetType.cat,
      age: 24,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      appointments: [
        PetAppointment(
          date: DateTime(2025, DateTime.october, 16, 17),
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
    Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
    ),
    Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
      appointments: [
        PetAppointment(
          date: DateTime(2025, DateTime.october, 14),
          description: "Waschen",
          type: AppointmentType.pflege,
        ),
      ],
    ),
    Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
    ),
    Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
    ),
  ];

  List<Pet> get pets => List.unmodifiable(_pets);
  int get numberOfPets => _pets.length;

  void addPet(Pet pet) {
    _pets.add(pet);
  }

  void removePet(Pet pet) {
    _pets.remove(pet);
  }

  void updatePet(Pet pet) {}

  void clearPet(Pet pet) {
    _pets.clear();
  }

  void addEntry(Pet pet, DiaryEntry entry) {
    pet.entries.add(entry);
  }

  void addAppointment(Pet pet, PetAppointment appointment) {
    pet.appointments.add(appointment);
  }
}

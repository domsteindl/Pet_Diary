import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/entry.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Dog extends Pet with HiveObjectMixin {
  @override
  bool get isAquatic => false;

  Dog({
    required super.name,
    required super.species,
    required super.age,
    required super.imageUrl,
    super.weight,
    super.description = "Keine Beschreibung vorhanden",
    super.appointments,
    super.entries,
  });

   factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      name: map['name'] as String,
      species: PetType.values.firstWhere((e) => e.name == map['species']),
      age: map['age'] as int,
      weight: (map['weight'] as num?)?.toDouble() ?? 1.0,
      imageUrl: map['imageUrl'] as String,
      description:
          map['description'] as String? ?? "Keine Beschreibung vorhanden",
      appointments:
          (map['appointments'] as List<dynamic>?)
              ?.map((a) => PetAppointment.fromMap(a))
              .toList() ??
          [],
      entries:
          (map['entries'] as List<dynamic>?)
              ?.map((e) => DiaryEntry.fromMap(e))
              .toList() ??
          [],
    );
  }
}

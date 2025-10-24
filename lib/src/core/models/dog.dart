import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Dog extends Pet with HiveObjectMixin {
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
}

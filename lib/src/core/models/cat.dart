import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Cat extends Pet with HiveObjectMixin {
  Cat({
    required super.name,
    required super.species,
    required super.age,
    required super.imageUrl,
    super.description,
    super.appointments,
    super.entries,
  });
}

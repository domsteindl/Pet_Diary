import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Fish extends Pet with HiveObjectMixin {
  Fish({
    required super.name,
    required super.species,
    required super.age,
    required super.imageUrl,
  });
}

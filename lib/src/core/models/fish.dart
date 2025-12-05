import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Fish extends Pet with HiveObjectMixin {
  @override
  bool get isAquatic => true;

  Fish({required super.name, required super.age, required super.imageUrl})
    : super(species: PetType.fish);

  factory Fish.fromMap(Map<String, dynamic> map) {
    return Fish(
      name: map['name'],
      age: map['age'],
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }
}

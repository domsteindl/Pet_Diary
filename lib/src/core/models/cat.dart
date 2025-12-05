import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/entry.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class Cat extends Pet with HiveObjectMixin {
  @override
  bool get isAquatic => false;

  Cat({
    required super.name,
    required super.age,
    required super.weight,
    required super.imageUrl,
    super.description,
    super.appointments,
    super.entries,
  }) : super(species: .cat);

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      name: map['name'] as String? ?? 'Unbekannt',
      age: (map['age'] as num?)?.toInt() ?? 0,
      weight: (map['weight'] as num?)?.toDouble() ?? 1.0,
      imageUrl: map['imageUrl'] as String? ?? '',
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

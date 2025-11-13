import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/models/dog.dart';
import 'package:pet_diary/src/core/models/entry.dart';

abstract class Pet {
  static int _idCounter = 0;
  final int id;
  final String name;
  final PetType species;
  final int age;
  final double weight;
  final String imageUrl;
  final String description;
  List<PetAppointment> appointments;
  List<DiaryEntry> entries;
  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
    this.description = "Keine Beschreibung vorhanden",
    this.weight = 1.0,
    List<PetAppointment>? appointments,
    List<DiaryEntry>? entries,
  }) : id = _idCounter++,
       appointments = appointments ?? [],
       entries = entries ?? [];

        Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species.name, 
      'age': age,
      'weight': weight,
      'imageUrl': imageUrl,
      'description': description,
      'appointments': appointments.map((a) => a.toMap()).toList(),
      'entries': entries.map((e) => e.toMap()).toList(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    switch (map['species'] as String) {
      case 'Dog':
        return Dog.fromMap(map);
      case 'Cat':
        return Cat.fromMap(map);
      default:
        throw Exception('Unknown PetType');
    }
  }
}

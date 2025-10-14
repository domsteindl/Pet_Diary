import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
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
}

import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/entry.dart';


abstract class Pet {
  static int _idCounter = 0;
  final int id;
  final String name;
  final PetType species;
  final int age;
  final String imageUrl;
  final String? description;
  final List<PetAppointment>? appointments;
  final List<Entry>? entries;
  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
    this.description = "Keine Beschreibung vorhanden",
    this.appointments,
    this.entries,
    
  }) : id = _idCounter++;

  
}
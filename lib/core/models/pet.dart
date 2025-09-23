import 'package:pet_diary/core/enums/pet_type.dart';
import 'package:pet_diary/core/models/appointment.dart';


class Pet {
  static int _idCounter = 0;
  final int id;
  final String name;
  final PetType species;
  final int age;
  final String imageUrl;
  final String? description;
  final List<PetAppointment>? appointments;
  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
    this.description = "Keine Beschreibung vorhanden",
    this.appointments,
    
  }) : id = _idCounter++;
}

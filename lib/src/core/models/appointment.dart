import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';

class PetAppointment extends HiveObject {
  final DateTime date;
  final String description;
  final AppointmentType type;

  PetAppointment({
    required this.date,
    required this.description,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'description': description,
      'type': type.name,
    };
  }


  factory PetAppointment.fromMap(Map<String, dynamic> map) {
    return PetAppointment(
      date: DateTime.parse(map['date'] as String),
      description: map['description'] as String,
      type: AppointmentType.values.firstWhere((e) => e.name == map['type']),
    );
  }

  @override
  String toString() {
    return '${_formattedDate()} - $description';
  }

  String _formattedDate() {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

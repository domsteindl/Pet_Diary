import 'package:pet_diary/src/core/enums/appointment_type.dart';

class PetAppointment {
  final DateTime date;
  final String description;
  final AppointmentType type;

  PetAppointment({
required this.date,
required this.description,
required this.type
  });
@override
  String toString() {
    return '${_formattedDate()} - $description';
  }

  String _formattedDate() {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}


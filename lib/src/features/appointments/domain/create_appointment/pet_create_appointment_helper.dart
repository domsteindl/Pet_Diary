import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/pet.dart';

String appointmentTypeLabel(AppointmentType type) {
  final firstChar = type.name.substring(0, 1).toUpperCase();
  final rest = type.name.substring(1);
  return '$firstChar$rest';
}

PetAppointment createAppointment({
  required Pet pet,
  required DateTime date,
  required AppointmentType type,
  required String description,
}) {
  final appointment = PetAppointment(
    date: date,
    type: type,
    description: description,
  );
  pet.appointments.add(appointment);
  return appointment;
}

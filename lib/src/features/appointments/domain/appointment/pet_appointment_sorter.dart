import 'package:pet_diary/src/core/models/pet.dart';

List<Pet> sortPetsByAppointment(
  List<Pet> pets,
  DateTime now,
  DateTime oneWeekFromNow,
) {
  List<Pet> petsSorted = pets
      .where(
        (pet) =>
            pet.appointments.isNotEmpty &&
            pet.appointments.any(
              (appointment) =>
                  appointment.date.isAfter(now) &&
                  appointment.date.isBefore(oneWeekFromNow),
            ),
      )
      .toList();

  petsSorted.sort((petA, petB) {
    final petAAppointments = petA.appointments
        .where(
          (appointment) =>
              appointment.date.isAfter(now) &&
              appointment.date.isBefore(oneWeekFromNow),
        )
        .map((appointment) => appointment.date)
        .reduce((dateA, dateB) => dateA.isBefore(dateB) ? dateA : dateB);

    final petBAppointments = petB.appointments
        .where(
          (appointment) =>
              appointment.date.isAfter(now) &&
              appointment.date.isBefore(oneWeekFromNow),
        )
        .map((appointment) => appointment.date)
        .reduce((dateA, dateB) => dateA.isBefore(dateB) ? dateA : dateB);

    return petAAppointments.compareTo(petBAppointments);
  });

  Set<Pet> animals = {};
  animals.addAll(petsSorted);
  animals.addAll(pets);
  petsSorted = animals.toList();
  return petsSorted;
}

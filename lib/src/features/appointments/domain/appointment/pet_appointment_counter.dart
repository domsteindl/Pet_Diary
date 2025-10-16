import 'package:pet_diary/src/core/models/pet.dart';

int countAppointmentsWithinWeek(
  List<Pet> pets,
  DateTime now,
  DateTime oneWeekFromNow,
) {
  return pets.fold<int>(
    0,
    (sum, pet) =>
        sum +
        pet.appointments
            .where(
              (a) => a.date.isAfter(now) && a.date.isBefore(oneWeekFromNow),
            )
            .length,
  );
}

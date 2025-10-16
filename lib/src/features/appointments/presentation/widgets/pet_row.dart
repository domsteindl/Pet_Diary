import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/utils/appointment_utils.dart';

class PetRow extends StatelessWidget {
  final Pet pet;
  const PetRow({required this.pet, super.key});

  @override
  Widget build(BuildContext context) {
    final helper = AppointmentUtils();
    final now = DateTime.now();
    final oneWeekFromNow = now.add(const Duration(days: 7));

    final hasFutureAppointments = pet.appointments.any(
      (a) => a.date.isAfter(now) && a.date.isBefore(oneWeekFromNow),
    );

    final upcoming =
        pet.appointments
            .where(
              (a) => a.date.isAfter(now) && a.date.isBefore(oneWeekFromNow),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    final nextDate = upcoming.isNotEmpty ? upcoming.first.date : null;

    final rowContent = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: pet.species.imagePath.endsWith(".svg")
              ? SvgPicture.asset(pet.species.imagePath, fit: BoxFit.contain)
              : Image.asset(pet.species.imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(pet.name)),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: helper.getAppointmentColor(nextDate),
              ),
              height: 20,
              width: 110,
              child: Text(helper.dateToHumanReadableString(nextDate)),
            ),
            const Positioned(left: -18, top: -18, child: Icon(Icons.info)),
          ],
        ),
      ],
    );

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: hasFutureAppointments
          ? InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Image.network(pet.imageUrl),
                      if (upcoming.isNotEmpty) ...[
                        Text(upcoming.first.description),
                        Text(helper.dateToLocalFormat(nextDate!)),
                        Text(helper.dateToHoursAndMinutes(nextDate)),
                      ],
                    ],
                  ),
                ),
              ),
              child: rowContent,
            )
          : Opacity(opacity: 0.5, child: rowContent),
    );

    return content;
  }
}

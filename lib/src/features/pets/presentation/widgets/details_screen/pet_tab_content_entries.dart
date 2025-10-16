import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/utils/appointment_utils.dart';

class TabContentEntries extends StatelessWidget {
  final Pet pet;
  static AppointmentUtils dateHelper = AppointmentUtils();
  const TabContentEntries({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    if (pet.entries.isEmpty) return const Text("Keine Einträge");

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pet.entries.length,
        itemBuilder: (context, index) {
          final entry = pet.entries[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(entry.type.icon),
              title: Text(entry.description ?? "Kein Titel"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entry.note != null) Text("Notiz: ${entry.note}"),
                  Text(
                    '${dateHelper.dateToLocalFormat(entry.date)} ${dateHelper.dateToHoursAndMinutes(entry.date)}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class TabContentAppointments extends StatelessWidget {
  final Pet pet;

  const TabContentAppointments({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    if (pet.appointments.isEmpty) return const Text("Keine Termine");

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pet.appointments.length,
        itemBuilder: (context, index) {
          final appointment = pet.appointments[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(appointment.description),
              subtitle: Text(
                "${appointment.date.day}.${appointment.date.month}.${appointment.date.year} "
                "${appointment.date.hour}:${appointment.date.minute.toString().padLeft(2, '0')}",
              ),
            ),
          );
        },
      ),
    );
  }
}

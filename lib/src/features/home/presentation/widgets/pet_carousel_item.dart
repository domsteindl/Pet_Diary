import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:table_calendar/table_calendar.dart';

class PetCarouselItem extends StatelessWidget {
  final Pet pet;
  const PetCarouselItem({super.key, required this.pet});

  Map<DateTime, List<PetAppointment>> _buildEvents() {
    final events = <DateTime, List<PetAppointment>>{};
    if (pet.appointments != null) {
      for (var appointment in pet.appointments!) {
        final day = DateTime(
          appointment.date.year,
          appointment.date.month,
          appointment.date.day,
        );
        events.putIfAbsent(day, () => []).add(appointment);
      }
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final events = _buildEvents();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),
                    child: Image.network(
                      pet.imageUrl,
                      width: 160,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text('${pet.age} Jahre alt'),
                        SizedBox(height: 5),
                        /*
                        Text(
                          'Typ: ${pet.species.label}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        */
                        Text('${pet.description}'),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 274,
                child: TableCalendar(
                  rowHeight: 32,
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(DateTime.now().year - 1, 1, 1),
                  lastDay: DateTime(DateTime.now().year + 1, 12, 31),
                  eventLoader: (day) {
                    final normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );
                    return events[normalizedDay] ?? [];
                  },
calendarBuilders: CalendarBuilders(
  defaultBuilder: (context, day, focusedDay) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final hasAppointments = events.containsKey(normalizedDay);

    if (hasAppointments) {
      return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _getMarkerColor(events[normalizedDay]!.length),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return null; // Standarddarstellung verwenden
  },
),
                ),
              ),

              //  Text('Nächster Termin: ${findNextAppointment(pet).toString()}'),
            ],
          ),
        ),

        /*
            Image.network(
              pet.imageUrl,
            ),
            SizedBox(height: 16),
            Text('${pet.species.name} ${pet.id + 1}'),
            */
      ),
    );
  }
}

PetAppointment? findNextAppointment(Pet pet) {
  DateTime current = DateTime.now();
  List<PetAppointment> upcomingAppointments = [];
  if (pet.appointments?.isEmpty ?? true) {
    return null;
  }
  upcomingAppointments = pet.appointments!
      .where((PetAppointment appointment) => appointment.date.isAfter(current))
      .toList();

  PetAppointment nextAppointment = upcomingAppointments.reduce(
    (firstDate, secondDate) =>
        firstDate.date.isBefore(secondDate.date) ? firstDate : secondDate,
  );
  return nextAppointment;
}

Color _getMarkerColor(int count) {
  if (count >= 5) return Colors.red;
  if (count >= 3) return Colors.orange;
  return Colors.green;
}

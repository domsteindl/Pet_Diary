import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/core/utils/appointment_utils.dart';

class PetAppointmentScreen extends StatefulWidget {
  const PetAppointmentScreen({super.key});

  @override
  State<PetAppointmentScreen> createState() => _PetAppointmentScreenState();
}

class _PetAppointmentScreenState extends State<PetAppointmentScreen> {
  final int petsPerTab = 6;
  int currentTab = 0;
  int previousTab = 0;

  @override
  Widget build(BuildContext context) {
    final pets = PetManager.instance.pets;
    final numberAppointments = pets.fold<int>(
      0,
      (sum, pet) =>
          sum +
          (pet.appointments ?? [])
              .where((a) => !a.date.isBefore(DateTime.now()))
              .length,
    );
    final numberOfTabs = (pets.length / petsPerTab).ceil();
    final start = currentTab * petsPerTab;
    final end = ((currentTab + 1) * petsPerTab).clamp(0, pets.length);
    final petsInTab = pets.sublist(start, end);
    final dynamicText = numberAppointments == 1
        ? "Du hast einen anstehenden Termin diese Woche!"
        : numberAppointments != 0
        ? "Du hast $numberAppointments anstehende Termine"
        : "Diese Woche stehen keine Termine an :)";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Termine',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(dynamicText),
        const SizedBox(height: 10),

        // --- Animated Sliding Transition ---
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            final inFromRight = currentTab > previousTab;

            final slideAnimation =
                Tween<Offset>(
                  begin: Offset(inFromRight ? 1 : -1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                );

            return SlideTransition(position: slideAnimation, child: child);
          },
          child: Padding(
            key: ValueKey(currentTab),
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: Column(
                children: petsInTab.asMap().entries.map((entry) {
                  int index = entry.key;
                  Pet pet = entry.value;
                  return Column(
                    children: [
                      _buildPetRow(pet),
                      if (index != petsInTab.length - 1)
                        Divider(
                          thickness: 1,
                          height: 20,
                          indent: 20,
                          endIndent: 40,
                          color: Colors.grey.withValues(alpha: 0.6),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        if (numberOfTabs > 1)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(numberOfTabs, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        previousTab = currentTab;
                        currentTab = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentTab == index
                          ? Colors.blue
                          : Colors.grey,
                      minimumSize: const Size(40, 40),
                    ),
                    child: Text('${index + 1}'),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildPetRow(Pet pet) {
    final hasAppointments = (pet.appointments ?? []).any((appointment) {
     return !appointment.date.isBefore(DateTime.now());
    },);
    AppointmentUtils helperFunctions = AppointmentUtils();
    final upcomingAppointments =
        (pet.appointments ?? [])
            .where((a) => !a.date.isBefore(DateTime.now()))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    DateTime? nextDate = upcomingAppointments.isNotEmpty
        ? upcomingAppointments.first.date
        : null;

    Widget row = Row(
      children: [
        if (pet.species.imagePath.contains(".svg"))
          SvgPicture.asset(pet.species.imagePath, width: 50, height: 50)
        else
          Image.asset(pet.species.imagePath, width: 50, height: 50),
        const SizedBox(width: 10),
        Expanded(child: Text(pet.name)),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: helperFunctions.getAppointmentColor(nextDate),
              ),
              height: 20,
              width: 110,
              child: Text(helperFunctions.dateToHumanReadableString(nextDate)),
            ),
            Positioned(left: -18, top: -18, child: Icon(Icons.info)),
          ],
        ),
      ],
    );

    Widget rowClickable = InkWell(
    
      onTap: () {
        
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
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
                  if (upcomingAppointments.isNotEmpty)
                    Column(
                      children: [
                        Text(upcomingAppointments.first.description),
                        Text(nextDate.toString()),
                        Text(helperFunctions.dateToHoursAndMinutes(nextDate!)),
                      ],
                    ),
                ],
              ),
            );
          },
        );
      },
      child: row,
    );
print('${pet.name} hasAppointments: $hasAppointments ${pet.appointments}');
    return Padding(
      
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Opacity(
        opacity: hasAppointments ? 1.0 : 0.5,
        child: hasAppointments ? rowClickable : row,
      ),
    );
  }
}

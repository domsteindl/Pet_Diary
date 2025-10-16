import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/appointments/domain/appointment/pet_appointment_counter.dart';
import 'package:pet_diary/src/features/appointments/domain/appointment/pet_appointment_sorter.dart';
import 'package:pet_diary/src/features/appointments/domain/appointment/pet_appointment_text.dart';
import 'package:pet_diary/src/features/appointments/domain/appointment/pet_pagination.dart';
import 'package:pet_diary/src/features/appointments/presentation/screens/pet_create_appointment.dart';
import 'package:pet_diary/src/features/appointments/presentation/widgets/pet_appointment_card.dart';

class PetAppointmentScreen extends StatefulWidget {
  const PetAppointmentScreen({super.key});

  @override
  State<PetAppointmentScreen> createState() => _PetAppointmentScreenState();
}

class _PetAppointmentScreenState extends State<PetAppointmentScreen> {
  final int petsPerTab = 4;
  int currentTab = 0;
  int previousTab = 0;

  @override
  Widget build(BuildContext context) {
    final pets = PetManager.instance.pets;
    final now = DateTime.now();
    final oneWeekFromNow = now.add(const Duration(days: 7));

    final petsSorted = sortPetsByAppointment(pets, now, oneWeekFromNow);
    final numberAppointments = countAppointmentsWithinWeek(
      pets,
      now,
      oneWeekFromNow,
    );

    final numberOfTabs = getNumberOfTabs(petsSorted, petsPerTab);
    final petsInTab = getPetsForTab(petsSorted, currentTab, petsPerTab);

    final dynamicText = getAppointmentMessage(numberAppointments);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 15),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PetCreateAppointmentScreen(),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Termine',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(dynamicText),
            const SizedBox(height: 5),

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
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    );
                return SlideTransition(position: slideAnimation, child: child);
              },
              child: Padding(
                key: ValueKey(currentTab),
                padding: const EdgeInsets.all(10.0),
                child: PetAppointmentCard(petsInTab: petsInTab),
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
                        child: Text('${index + 1}'),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

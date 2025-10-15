import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class PetCreateAppointmentScreen extends StatefulWidget {
  const PetCreateAppointmentScreen({super.key});

  @override
  State<PetCreateAppointmentScreen> createState() =>
      _PetCreateAppointmentScreenState();
}

class _PetCreateAppointmentScreenState
    extends State<PetCreateAppointmentScreen> {
  DateTime? selectedDate;
  int _currentStep = 0;
  String description = '';
  Pet? selectedPet = PetManager.instance.pets[0];
  AppointmentType? selectedType = AppointmentType.values[0];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, DateTime.january, 01);
    DateTime lastDate = DateTime(now.year, DateTime.december, 31);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Termin erstellen",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top : 40.0),
          child: Stepper(
            currentStep: _currentStep,
            controlsBuilder: (context, details) {
              final isLastStep = _currentStep == 3;
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  spacing: 10,
                  children: [
                    if (!isLastStep)
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          'Weiter',
                        ), // Standard für alle außer letzten Step
                      ),
                          
                    if (isLastStep)
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          'Termin erstellen',
                        ), // spezieller Text für letzten Step
                      ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text('Zurück'),
                    ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                isActive: _currentStep == 0,
                title: Text(
                  'Für welches deiner Tiere soll ein Termin erstellt werden?',
                ),
                
                content: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 0),
                  child: DropdownMenuFormField(
                    label: Text("Deine Tiere"),
                    initialSelection: selectedPet,
                    dropdownMenuEntries: List.generate(
                      PetManager.instance.numberOfPets,
                      (index) {
                        Pet pet = PetManager.instance.pets[index];
                        return DropdownMenuEntry(value: pet, label: pet.name);
                      },
                    ),
                    onSelected: (pet) {
                      setState(() {
                        selectedPet = pet;
                      });
                    },
                  ),
                ),
              ),
          
              Step(
                isActive: _currentStep == 1,
                // state: selectedDate != null
                //     ? StepState.complete
                //     : StepState.indexed,
                title: Text('Datum angeben'),
                content: Column(
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Kein Datum gewählt'
                          : selectedDate!.toLocal().toString().split(
                              ' ',
                            )[0],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                      child: ElevatedButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            currentDate: DateTime.now(),
                            firstDate: firstDate,
                            lastDate: lastDate,
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Text('Datum wählen'),
                      ),
                    ),
                  ],
                ),
              ),
              Step(
                isActive: _currentStep == 2,
                title: Text("Terminart auswählen"),
                content: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DropdownMenuFormField(
                    label: Text("Art des Termins"),
                    initialSelection: selectedType,
                    dropdownMenuEntries: List.generate(
                      AppointmentType.values.length,
                      (index) {
                        AppointmentType appointmentType =
                            AppointmentType.values[index];
                        String firstCharToUppercase = appointmentType.name
                            .substring(0, 1)
                            .toUpperCase();
                        String labelToUppercase =
                            '$firstCharToUppercase${appointmentType.name.substring(1, appointmentType.name.length)}';
                        return DropdownMenuEntry(
                          value: appointmentType,
                          label: labelToUppercase,
                        );
                      },
                    ),
                    onSelected: (type) {
                      setState(() {
                        selectedType = type;
                      });
                    },
                  ),
                ),
              ),
              Step(
                isActive: _currentStep == 3,
                title: Text('Beschreibung eingeben'),
                content: TextField(
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Beschreibung',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
              ),
            ],
          
            onStepCancel: _currentStep == 0
                ? null
                : () {
                    setState(() {});
                    if (_currentStep != 0) {
                      _currentStep--;
                    }
                  },
          
            onStepContinue: _currentStep < 3
                ? () {
                    if (_currentStep <= 2) {
                      setState(() {
                        _currentStep++;
                      });
                    }
                  }
                : () {
                    // Letzter Step: Termin erstellen
                    if (selectedPet != null &&
                        selectedDate != null &&
                        selectedType != null) {
                      // Neuen Termin erstellen
                      final newAppointment = PetAppointment(
                        date: selectedDate!,
                        type: selectedType!,
                        description: description,
                      );
          
                      // Termin dem Tier hinzufügen
                      selectedPet!.appointments.add(newAppointment);
          
                      // Seite schließen
                      Navigator.of(context).pop();
          
                      ScaffoldMessenger.of(context).clearSnackBars();
                      // SnackBar anzeigen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erfolgreich angelegt'),
                        ),
                      );
                    } else {
                      // Optional: Fehlermeldung, falls etwas fehlt
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bitte alle Felder ausfüllen'),
                        ),
                      );
                    }
                  },
          ),
        ),
      ),
    );
  }
}

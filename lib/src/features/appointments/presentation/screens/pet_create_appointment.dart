import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/appointments/domain/create_appointment/pet_create_appointment_helper.dart';
import 'package:pet_diary/src/features/appointments/presentation/widgets/pet_appointment_type_dropdown.dart';
import 'package:pet_diary/src/features/appointments/presentation/widgets/pet_date_picker_step.dart';
import 'package:pet_diary/src/features/appointments/presentation/widgets/pet_dropdown.dart';

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
  Pet? selectedPet = PetManager().pets[0];
  AppointmentType? selectedType = AppointmentType.values[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Termin erstellen",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Stepper(
            currentStep: _currentStep,
            controlsBuilder: (context, details) {
              final isLastStep = _currentStep == 3;
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'Termin erstellen' : 'Weiter'),
                    ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Zurück'),
                    ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                isActive: _currentStep == 0,
                title: const Text(
                  'Für welches deiner Tiere soll ein Termin erstellt werden?',
                ),
                content: PetDropdown(
                  selectedPet: selectedPet,
                  onChanged: (pet) => setState(() => selectedPet = pet),
                ),
              ),
              Step(
                isActive: _currentStep == 1,
                title: const Text('Datum angeben'),
                content: DatePickerStep(
                  selectedDate: selectedDate,
                  onDatePicked: (date) => setState(() => selectedDate = date),
                ),
              ),
              Step(
                isActive: _currentStep == 2,
                title: const Text('Terminart auswählen'),
                content: AppointmentTypeDropdown(
                  selectedType: selectedType,
                  onChanged: (type) => setState(() => selectedType = type),
                ),
              ),
              Step(
                isActive: _currentStep == 3,
                title: const Text('Beschreibung eingeben'),
                content: TextField(
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Beschreibung',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => description = value),
                ),
              ),
            ],
            onStepCancel: _currentStep == 0
                ? null
                : () => setState(() {
                    if (_currentStep != 0) _currentStep--;
                  }),
            onStepContinue: _currentStep < 3
                ? () => setState(() => _currentStep++)
                : () {
                    if (selectedPet != null &&
                        selectedDate != null &&
                        selectedType != null) {
                      createAppointment(
                        pet: selectedPet!,
                        date: selectedDate!,
                        type: selectedType!,
                        description: description,
                      );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erfolgreich angelegt')),
                      );
                    } else {
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

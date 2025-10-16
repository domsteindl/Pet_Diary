import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/features/appointments/domain/create_appointment/pet_create_appointment_helper.dart';

class AppointmentTypeDropdown extends StatelessWidget {
  final AppointmentType? selectedType;
  final Function(AppointmentType?) onChanged;

  const AppointmentTypeDropdown({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField(
      label: const Text("Art des Termins"),
      initialSelection: selectedType,
      dropdownMenuEntries: List.generate(AppointmentType.values.length, (
        index,
      ) {
        final type = AppointmentType.values[index];
        return DropdownMenuEntry(
          value: type,
          label: appointmentTypeLabel(type),
        );
      }),
      onSelected: onChanged,
    );
  }
}

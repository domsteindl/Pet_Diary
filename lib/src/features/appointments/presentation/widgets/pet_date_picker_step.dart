import 'package:flutter/material.dart';

class DatePickerStep extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDatePicked;

  const DatePickerStep({
    super.key,
    required this.selectedDate,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, DateTime.january, 1);
    final lastDate = DateTime(now.year, DateTime.december, 31);

    return Column(
      children: [
        Text(
          selectedDate == null
              ? 'Kein Datum gewählt'
              : selectedDate!.toLocal().toString().split(' ')[0],
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
                onDatePicked(pickedDate);
              }
            },
            child: const Text('Datum wählen'),
          ),
        ),
      ],
    );
  }
}

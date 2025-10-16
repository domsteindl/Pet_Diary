import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/features/appointments/presentation/widgets/pet_row.dart';

class PetAppointmentCard extends StatelessWidget {
  final List<Pet> petsInTab;
  const PetAppointmentCard({required this.petsInTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      elevation: 1,
      child: Column(
        children: [
          for (int i = 0; i < petsInTab.length; i++) ...[
            PetRow(pet: petsInTab[i]),
            if (i != petsInTab.length - 1)
              Divider(
                thickness: 1,
                height: 20,
                indent: 20,
                endIndent: 40,
                color: Colors.grey.withValues(alpha: 0.6),
              ),
          ],
        ],
      ),
    );
  }
}

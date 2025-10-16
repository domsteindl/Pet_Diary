import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_tab_content_appointments.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_tab_content_basic.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_tab_content_entries.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_tab_content_nutrition.dart';

class TabContentWrapper extends StatelessWidget {
  final int index;
  final Pet pet;

  const TabContentWrapper({super.key, required this.index, required this.pet});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return TabContentEntries(pet: pet);
      case 1:
        return TabContentBasic(pet: pet);
      case 2:
        return const TabContentNutrition();
      case 3:
        return TabContentAppointments(pet: pet);
      default:
        return const SizedBox.shrink();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class PetDropdown extends StatelessWidget {
  final Pet? selectedPet;
  final Function(Pet?) onChanged;

  const PetDropdown({
    super.key,
    required this.selectedPet,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField(
      label: const Text("Deine Tiere"),
      initialSelection: selectedPet,
      dropdownMenuEntries: List.generate(PetManager.instance.numberOfPets, (
        index,
      ) {
        Pet pet = PetManager.instance.pets[index];
        return DropdownMenuEntry(value: pet, label: pet.name);
      }),
      onSelected: onChanged,
    );
  }
}

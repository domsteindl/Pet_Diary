// domain/pet_pagination.dart
import 'package:pet_diary/src/core/models/pet.dart';

List<Pet> getPetsForTab(List<Pet> pets, int currentTab, int petsPerTab) {
  final start = currentTab * petsPerTab;
  final end = ((currentTab + 1) * petsPerTab).clamp(0, pets.length);
  return pets.sublist(start, end);
}

int getNumberOfTabs(List<Pet> pets, int petsPerTab) {
  return (pets.length / petsPerTab).ceil();
}

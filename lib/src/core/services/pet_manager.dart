import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/Cat.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/dog.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class PetManager {
 

  PetManager._privateConstructor();

  static final PetManager instance = PetManager._privateConstructor();

  final List<Pet> _pets = [    Cat(
      name: "Luna",
      species: PetType.cat,
      age: 24,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      appointments: [
        PetAppointment(
          date: DateTime(2025, DateTime.october, 10, 17),
          description: "Entläusen",
        ),
        PetAppointment(
          date: DateTime(2025, DateTime.october, 09, 18, 2),
          description: "Haare Schneiden",
        ),
        
        PetAppointment(
          date: DateTime(2025, DateTime.september, 28),
          description: "Waschen",
        ),
      ],
    ),
    Cat(
      name: "Mark",
      species: PetType.cat,
      age: 22,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    ),
    Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
      
    ), Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
      
    ), Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
      
    ), Dog(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
      description: "Verschmusst, liebt Eiscreme und Katzenminze",
      
    ),];

  List<Pet> get pets => List.unmodifiable(_pets);
  int get numberOfPets => _pets.length;

  void addPet(Pet pet) {
    _pets.add(pet);
  }

  void removePet(Pet pet) {
    _pets.remove(pet);
  }

  void updatePet(Pet pet) {}

  void clearPet(Pet pet) {
    _pets.clear();
  }
}

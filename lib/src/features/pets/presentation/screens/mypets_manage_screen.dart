import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class MypetsManageScreen extends StatefulWidget {
  const MypetsManageScreen({super.key});

  @override
  State<MypetsManageScreen> createState() => _PetManageScreenState();
}

class _PetManageScreenState extends State<MypetsManageScreen> {
  List<Pet> pets = PetManager().pets;

  void _deletePet(Pet pet) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Haustier löschen"),
        content: Text("Willst du ${pet.name} wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Abbrechen"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pets.remove(pet);
              });
              Navigator.of(context).pop();
            },
            child: const Text("Löschen"),
          ),
        ],
      ),
    );
  }

  // void _editPet(Pet pet) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ManagePetFormScreen(pet: pet),
  //     ),
  //   );
  //   setState(() {});
  // }

  // void _createPet() async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => const ManagePetFormScreen(),
  //     ),
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tiertagebuch",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 3,
      ),

      body: SafeArea(child: Text("")),
    );
  }
}

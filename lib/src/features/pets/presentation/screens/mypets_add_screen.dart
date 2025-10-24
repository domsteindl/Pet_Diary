import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class MypetsAddScreen extends StatefulWidget {
  MypetsAddScreen({super.key});

  @override
  State<MypetsAddScreen> createState() => _MypetsAddScreenState();
}

class _MypetsAddScreenState extends State<MypetsAddScreen> {
  bool showPet = false;
  final Cat pet = Cat(
    name: "TestObjekt",
    species: PetType.cat,
    age: 5,
    imageUrl: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              FilledButton(
                onPressed: () => setState(() {
                  PetManager().addPet(pet);
                  showPet = true;
                }),
                child: Text("Tier hinzufügen"),
              ),

              showPet
                  ? Text(PetManager().getPet(pet.id)!.name)
                  : Text("Kein Tier"),
            ],
          ),
        ),
      ),
    );
  }
}

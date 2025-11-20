import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/hive_service.dart';


class MypetsAddScreen extends StatefulWidget {
  const MypetsAddScreen({super.key});

  @override
  State<MypetsAddScreen> createState() => _MypetsAddScreenState();
}

class _MypetsAddScreenState extends State<MypetsAddScreen> {
  bool showPet = false;
  final Cat pet = Cat(
    name: "TestObjekt",
    species: PetType.cat,
    weight: 2.0,
    age: 5,
    imageUrl: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("All deine Racker\nfindest du hier :)"),
        elevation: 3,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: SearchAnchor.bar(
                    suggestionsBuilder: (context, controller) {
                      final String input = controller.text;

                      return HiveService.getAllPets()
                          .where((Pet pet) => pet.species.label.contains(input))
                          .map((e) => Text(e.name))
                          .toList();
                    },

                    //   trailing: Iterable.empty(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:pet_diary/src/core/models/pet.dart';

class MyPetsDetailsScreen extends StatefulWidget {
  final int index;
  final Pet pet;
  final VoidCallback? callback;

  const MyPetsDetailsScreen({
    super.key,
    required this.pet,
    required this.index,
    this.callback,
  });

  @override
  State<MyPetsDetailsScreen> createState() => _MyPetsDetailsScreenState();
}

class _MyPetsDetailsScreenState extends State<MyPetsDetailsScreen> {
  int selectedTab = 0;

  final List<String> tabLabels = [
    "Tagebuch",
    "Grunddaten",
    "Ernährung",
    "Termine",
  ];

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

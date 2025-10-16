import 'package:flutter/material.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_tab_content_wrapper.dart';
import 'package:pet_diary/src/features/pets/presentation/widgets/details_screen/pet_vertical_tabs.dart';
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
      appBar: AppBar(title: Text(widget.pet.name)),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Hero(
                tag: 'tag_${widget.index}',
                child: Image.network(
                  widget.pet.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  VerticalTabs(
                    labels: tabLabels,
                    selectedIndex: selectedTab,
                    onTabSelected: (index) =>
                        setState(() => selectedTab = index),
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      color: Colors.grey[100],
                      child: TabContentWrapper(
                        index: selectedTab,
                        pet: widget.pet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

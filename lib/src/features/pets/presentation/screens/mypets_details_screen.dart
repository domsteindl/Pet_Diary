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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.pet.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        elevation: 3,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                elevation: 2,
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
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: VerticalTabs(
                      labels: tabLabels,
                      selectedIndex: selectedTab,
                      onTabSelected: (index) =>
                          setState(() => selectedTab = index),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0.2, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        key: ValueKey(selectedTab),
                        height: double.infinity,
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 10),
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHigh,
                        child: TabContentWrapper(
                          index: selectedTab,
                          pet: widget.pet,
                        ),
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

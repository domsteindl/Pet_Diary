import 'package:flutter/material.dart';
import 'package:pet_diary/main.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = PetManager.instance.pets;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Tiertagebuch")),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            OutlinedButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                  MainApp.of(
                    context,
                  )?.changeTheme(isDark ? ThemeMode.dark : ThemeMode.light);
                });
              },
              child: Text("Theme Wechseln"),
            ),
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: pets.length,
                shrinkWrap: true,
                 separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  Pet pet = pets[index];
                  return SizedBox(
                    width: 150,
                    height: 190,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Theme.of(
                        context,
                      ).colorScheme.surface, // Theme-konform
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                pet.imageUrl,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 60,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest, // heller/dunkler Container
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16.0,
                                  8,
                                  0,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                    ),
                                    Text(
                                      pet.species.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Heutiges Tagebuch"),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest, // Theme-konform
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Entry Placeholder",
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Image.network(pets[0].imageUrl, height: 100),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              "Text1",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                            Text(
                              "Text2",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Schnellaktionen"),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      QuickActionButton(label: "Tier anlegen"),
                      QuickActionButton(label: "Termin erstellen"),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      QuickActionButton(label: "Tagebucheintrag"),
                      QuickActionButton(label: "Test"),
                    ],
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

class QuickActionButton extends StatelessWidget {
  final String label;
  const QuickActionButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.surfaceContainerHighest, // Theme-konformer Hintergrund
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60,
      width: 165,
      child: GestureDetector(
        onTap: () {

        },
        child: ListTile(
          leading: Icon(
            Icons.book,
            size: 30,
            color: theme.colorScheme.onSurface,
          ),
          title: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface, // Theme-konforme Textfarbe
            ),
          ),
        ),
      ),
    );
  }
}

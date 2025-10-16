import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';

class MyPetsDetailsScreen extends StatefulWidget {
  final int index;
  final Pet pet;
  final VoidCallback? callback;

  const MyPetsDetailsScreen({
    super.key,
    this.callback,
    required this.pet,
    required this.index,
  });

  @override
  State<MyPetsDetailsScreen> createState() => _MyPetsDetailsScreenState();
}

class _MyPetsDetailsScreenState extends State<MyPetsDetailsScreen> {
  int selectedTab = 0; // 0 = Grunddaten, 1 = Ernährung, 2 = Termine

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
            // Hero-Bild oben
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

            // Tabs + Content
            Expanded(
              child: Row(
                children: [
                  // Vertikale Tabs
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(tabLabels.length, (index) {
                      final isSelected = selectedTab == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: Container(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              tabLabels[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  // Content rechts
                  Expanded(
                    child: Container(
                      height: 500,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      color: Colors.grey[100],
                      child: _buildTabContent(selectedTab),
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

  Widget _buildTabContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return SingleChildScrollView(
          child: widget.pet.entries.isEmpty
              ? const Text("Keine Einträge")
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.pet.entries.length,
                  itemBuilder: (context, index) {
                    final entry = widget.pet.entries[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          entry.type.icon
                        ),
                        title: Text(entry.description ?? "Kein Titel"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (entry.note != null) Text("Notiz: ${entry.note}"),
                            Text(
                              "${entry.date.day}.${entry.date.month}.${entry.date.year} "
                              "${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      case 1: // Grunddaten
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.pet.name}"),
            Text("Art: ${widget.pet.species.label}"),
            Text("Alter: ${widget.pet.age}"),
            Text("Gewicht: ${widget.pet.weight}kg"),
          ],
        );
      case 2: // Ernährung
        return Text("Hier kommen die Futter-Infos hin");
      case 3: // Termine
        return SingleChildScrollView(
          child: widget.pet.appointments.isEmpty
              ? const Text("Keine Termine")
              : ListView.builder(
                  shrinkWrap: true, // wichtig, damit es in Column/ListView passt
                  physics:
                      const NeverScrollableScrollPhysics(), // Scrollen vermeiden, falls es in Column ist
                  itemCount: widget.pet.appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = widget.pet.appointments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.event),
                        title: Text(appointment.description),
                        subtitle: Text(
                          "${appointment.date.day}.${appointment.date.month}.${appointment.date.year} ${appointment.date.hour}:${appointment.date.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    );
                  },
                ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

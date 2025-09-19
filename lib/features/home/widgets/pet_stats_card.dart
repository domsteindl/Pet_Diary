import 'package:flutter/material.dart';

class PetStatsCard extends StatelessWidget {
  const PetStatsCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text("Anzahl Haustiere: 0"),
              OutlinedButton(
                onPressed: null,
                child: Text("Haustier hinzufügen"),
              ),
            ],
          ),
          Row(
            children: [
              Text("Anzahl Wichtige Termine: 0"),
              OutlinedButton(onPressed: null, child: Text("Termin hinzufügen")),
            ],
          ),
        ],
      ),
    );
  }
}

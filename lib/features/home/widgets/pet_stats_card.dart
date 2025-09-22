import 'package:flutter/material.dart';

class PetStatsCard extends StatefulWidget {
  const PetStatsCard({super.key});

  @override
  State<PetStatsCard> createState() => _PetStatsCardState();
}

class _PetStatsCardState extends State<PetStatsCard> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row( 
                spacing: 20.0,
                children: [
                  Text("Anzahl Haustiere: 0"),
                  OutlinedButton(
                    onPressed: null,
                    child: Text("Haustier hinzufügen"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                spacing: 20.0,
                children: [
                  Text("Anzahl Wichtige Termine: 0"),
                  OutlinedButton(onPressed: null, child: Text("Termin hinzufügen")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PetStatsCard extends StatefulWidget {
  const PetStatsCard({super.key});

  @override
  State<PetStatsCard> createState() => _PetStatsCardState();
}

class _PetStatsCardState extends State<PetStatsCard> {



   @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatRow("Anzahl Haustiere: 0", "Haustier hinzufügen"),
            SizedBox(height: 12),
            _buildStatRow("Anzahl wichtige Termine: 0", "Termin hinzufügen"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String buttonLabel) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        OutlinedButton( // Buttons gleiche Länge - Vielleicht Opacity - Struktur zu blockig?
          onPressed: () {},
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}
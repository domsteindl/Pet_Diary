import 'package:flutter/material.dart';

enum EntryType {
  
  food(Icons.restaurant),
  health(Icons.local_hospital),
  activity(Icons.directions_run),
  note(Icons.note);

  final IconData icon;

  const EntryType(this.icon);
}

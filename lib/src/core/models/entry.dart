import 'package:pet_diary/src/core/enums/entry_type.dart';

class Entry {
  
  final DateTime date;
  final EntryType type;
  String? description;
  String? note;
  Map<dynamic, dynamic>? customFields;
  Entry({
    required this.date,
    required this.type,
    this.description,
    this.customFields,
    this.note
  });
}
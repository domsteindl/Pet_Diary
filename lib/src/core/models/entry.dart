import 'package:pet_diary/src/core/enums/entry_type.dart';

class DiaryEntry {
  
  final DateTime date;
  final EntryType type;
  String? description;
  String? note;
  Map<dynamic, dynamic>? customFields;
  DiaryEntry({
    required this.date,
    required this.type,
    this.description,
    this.customFields,
    this.note
  });
}
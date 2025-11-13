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

    Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'type': type.name,
      'description': description,
      'note': note,
      'customFields': customFields,
    };
  }


  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      date: DateTime.parse(map['date'] as String),
      type: EntryType.values.firstWhere((e) => e.name == map['type']),
      description: map['description'] as String?,
      note: map['note'] as String?,
      customFields: (map['customFields'] as Map?)?.cast<String, dynamic>(),
    );
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class CatAdapter extends TypeAdapter<Cat> {
  @override
  final typeId = 0;

  @override
  Cat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cat(
      name: fields[1] as String,
      species: fields[2] as PetType,
      age: (fields[3] as num).toInt(),
      imageUrl: fields[4] as String,
      description: fields[5] == null
          ? "Keine Beschreibung vorhanden"
          : fields[5] as String,
      appointments: (fields[6] as List?)?.cast<PetAppointment>(),
      entries: (fields[7] as List?)?.cast<DiaryEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cat obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.species)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.appointments)
      ..writeByte(7)
      ..write(obj.entries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PetTypeAdapter extends TypeAdapter<PetType> {
  @override
  final typeId = 1;

  @override
  PetType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PetType.cat;
      case 1:
        return PetType.dog;
      default:
        return PetType.cat;
    }
  }

  @override
  void write(BinaryWriter writer, PetType obj) {
    switch (obj) {
      case PetType.cat:
        writer.writeByte(0);
      case PetType.dog:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PetAppointmentAdapter extends TypeAdapter<PetAppointment> {
  @override
  final typeId = 3;

  @override
  PetAppointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetAppointment(
      date: fields[0] as DateTime,
      description: fields[1] as String,
      type: fields[2] as AppointmentType,
    );
  }

  @override
  void write(BinaryWriter writer, PetAppointment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetAppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppointmentTypeAdapter extends TypeAdapter<AppointmentType> {
  @override
  final typeId = 4;

  @override
  AppointmentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppointmentType.friseur;
      case 1:
        return AppointmentType.arzt;
      case 2:
        return AppointmentType.pflege;
      case 3:
        return AppointmentType.besonders;
      case 4:
        return AppointmentType.medikamente;
      case 5:
        return AppointmentType.impfung;
      case 6:
        return AppointmentType.freizeit;
      default:
        return AppointmentType.friseur;
    }
  }

  @override
  void write(BinaryWriter writer, AppointmentType obj) {
    switch (obj) {
      case AppointmentType.friseur:
        writer.writeByte(0);
      case AppointmentType.arzt:
        writer.writeByte(1);
      case AppointmentType.pflege:
        writer.writeByte(2);
      case AppointmentType.besonders:
        writer.writeByte(3);
      case AppointmentType.medikamente:
        writer.writeByte(4);
      case AppointmentType.impfung:
        writer.writeByte(5);
      case AppointmentType.freizeit:
        writer.writeByte(6);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiaryEntryAdapter extends TypeAdapter<DiaryEntry> {
  @override
  final typeId = 5;

  @override
  DiaryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryEntry(
      date: fields[0] as DateTime,
      type: fields[1] as EntryType,
      description: fields[2] as String?,
      customFields: (fields[4] as Map?)?.cast<dynamic, dynamic>(),
      note: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.customFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EntryTypeAdapter extends TypeAdapter<EntryType> {
  @override
  final typeId = 6;

  @override
  EntryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EntryType.food;
      case 1:
        return EntryType.health;
      case 2:
        return EntryType.activity;
      case 3:
        return EntryType.note;
      default:
        return EntryType.food;
    }
  }

  @override
  void write(BinaryWriter writer, EntryType obj) {
    switch (obj) {
      case EntryType.food:
        writer.writeByte(0);
      case EntryType.health:
        writer.writeByte(1);
      case EntryType.activity:
        writer.writeByte(2);
      case EntryType.note:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

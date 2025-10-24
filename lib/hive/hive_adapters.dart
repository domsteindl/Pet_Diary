import 'package:hive_ce/hive.dart';
import 'package:pet_diary/src/core/enums/appointment_type.dart';
import 'package:pet_diary/src/core/enums/entry_type.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/fish.dart';
import 'package:pet_diary/src/core/models/appointment.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/models/dog.dart';
import 'package:pet_diary/src/core/models/entry.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Cat>(),
  AdapterSpec<PetType>(),
  AdapterSpec<PetAppointment>(),
  AdapterSpec<AppointmentType>(),
  AdapterSpec<DiaryEntry>(),
  AdapterSpec<EntryType>(),
])
class HiveAdapters {}

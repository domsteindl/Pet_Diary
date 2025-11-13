import 'hive_service.dart';
import 'supabase_service.dart';

class Services {
  static Future<void> initAll() async {
    await HiveService.init();
    await SupabaseService.init();
  }
}

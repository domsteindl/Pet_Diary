import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static late final SupabaseClient client;

  static Future<void> init() async {
    // Stelle sicher, dass .env geladen ist
    await dotenv.load(fileName: ".env");

    client = SupabaseClient(
      dotenv.env['SUPABASE_URL']!,
      dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }
}

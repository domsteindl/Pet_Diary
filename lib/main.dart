import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_diary/src/core/services/services.dart';
import 'package:pet_diary/src/features/home/presentation/screens/home_screen.dart';
import 'package:pet_diary/src/features/onboarding/domain/onboarding_controller.dart';
import 'package:pet_diary/src/features/onboarding/presentation/pet_onboarding_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Services.initAll();
  await Services.syncAll();

  //await PetManager().init();

  runApp(const ProviderScope(child: MainApp()));

  FlutterNativeSplash.remove();
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingAsync = ref.watch(onboardingProvider);
    return onboardingAsync.when(
      data: (seenOnboarding) {
        return MaterialApp(
          home: seenOnboarding ? const HomeScreen() : const OnboardingScreen(),
        );
      },
      error: (error, stackTrace) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Fehler: $error'))),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}

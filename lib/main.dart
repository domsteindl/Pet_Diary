// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/login/presentation/pet_login_screen.dart';
import 'package:pet_diary/src/features/navigation/presentation/screens/shell_screen.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/mypets_add_screen.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/mypets_manage_screen.dart';
import 'package:pet_diary/src/theme/theme.dart';
import 'package:pet_diary/src/theme/util.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PetManager().init();

  runApp(const MainApp());
  Future.delayed(Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
  });
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  // ignore: library_private_types_in_public_api
  static _MainAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>();
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode newMode) {
    setState(() {
      _themeMode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Google Fonts TextTheme erstellen
        TextTheme textTheme = createTextTheme(
          context,
          "Aclonica", // Body Font
          "Aclonica", // Display Font
        );
        // MaterialTheme mit TextTheme
        MaterialTheme theme = MaterialTheme(textTheme);

        return MaterialApp(
          showPerformanceOverlay: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => MypetsAddScreen(),
            '/manage_pets': (context) => MypetsManageScreen(),
            '/home': (context) => ShellScreen(),
          },
          title: 'Pet Diary',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: _themeMode,
        );
      },
    );
  }
}

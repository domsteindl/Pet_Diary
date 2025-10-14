// main.dart
import 'package:flutter/material.dart';
import 'package:pet_diary/src/features/navigation/presentation/screens/shell_screen.dart';
import 'package:pet_diary/src/theme/theme.dart';
import 'package:pet_diary/src/theme/util.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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
        // Plattform-Helligkeit
        final brightness = MediaQuery.platformBrightnessOf(context);

        // Google Fonts TextTheme erstellen
        TextTheme textTheme = createTextTheme(
          context,
          "Aclonica", // Body Font
          "Aclonica", // Display Font
        );
        // MaterialTheme mit TextTheme
        MaterialTheme theme = MaterialTheme(textTheme);

        return MaterialApp(
          title: 'Pet Diary',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: _themeMode,
          home: const ShellScreen(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/screens/home_screen.dart';
import 'package:pet_diary/src/features/login/presentation/pet_login_screen.dart';
import 'package:pet_diary/src/features/navigation/presentation/screens/shell_screen.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/mypets_manage_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PetManager().init();

  runApp(const MainApp());

  Future.delayed(const Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
  });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Diary',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/manage_pets': (context) => const MypetsManageScreen(),
        '/shell': (context) => const ShellScreen(),
      },
    );
  }
}

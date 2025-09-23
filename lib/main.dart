import 'package:flutter/material.dart';
import 'package:pet_diary/features/navigation/presentation/shell_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Diary',
      theme: ThemeData(
       textTheme: TextTheme(
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 14), 
        labelSmall: TextStyle(color: Colors.grey[600])
       )),
      home: ShellScreen(),
    );
  }
}

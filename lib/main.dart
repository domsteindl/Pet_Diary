import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Pet Diary',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(title: Text("Tiertagebuch"),),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

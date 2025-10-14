import 'package:flutter/material.dart';

class PetCreateAppointmentScreen extends StatelessWidget {
  const PetCreateAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [Form(child: Text("Test"))]),
        ),
      ),
    );
  }
}

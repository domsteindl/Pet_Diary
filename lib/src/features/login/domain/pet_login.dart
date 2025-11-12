import 'package:flutter/material.dart';

class PetLogin {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final BuildContext context;
  PetLogin({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.context,
  });

  void login() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      //später DB/API Login einfügen
      print("Login mit $email / $password");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login erfolgreich (Demo)!')));

      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}

import 'package:flutter/material.dart';
import 'login_screen.dart'; // Această linie importă ecranul de login

void main() {
  runApp(const PawsNowApp());
}

class PawsNowApp extends StatelessWidget {
  const PawsNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paws Now',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange, // Culoare potrivită pentru o aplicație cu animale
        useMaterial3: true,
      ),
      home:  LoginScreen(), // Pornește direct cu ecranul de login
    );
  }
}
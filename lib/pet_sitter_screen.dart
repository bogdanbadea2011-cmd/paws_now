import 'package:flutter/material.dart';

class PetSitterScreen extends StatefulWidget {
const PetSitterScreen({super.key});

  @override
  State<PetSitterScreen> createState() => _PetSitterScreenState();
}

class _PetSitterScreenState extends State<PetSitterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Găsește Pet Sitter (Vacanță)'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.house, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Aici vei găsi persoanele disponibile\nsă îți găzduiască animalul în vacanță!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Loc pentru acțiune ulterioară
              },
              icon: const Icon(Icons.search),
              label: const Text('Caută sitteri disponibili'),
            ),
          ],
        ),
      ),
    );
  }
}
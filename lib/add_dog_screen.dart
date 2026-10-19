import 'package:flutter/material.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  // Controlerele care citesc textul scris de tine în căsuțe
  final nameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaugă un Cățel'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nume cățel',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: breedController,
              decoration: const InputDecoration(
                labelText: 'Rasă',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Vârstă (ani)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Când apeși pe buton, colectăm datele scrise
                  String name = nameController.text;
                  String breed = breedController.text;
                  String age = ageController.text;

                  // Dacă numele nu este gol, trimitem pachetul înapoi la ecranul principal
                  if (name.isNotEmpty) {
                    Navigator.pop(context, {
                      'name': name,
                      'breed': breed.isNotEmpty ? breed : 'Rasă necunoscută',
                      'age': age.isNotEmpty ? age : '0',
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Salvează Cățelul', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
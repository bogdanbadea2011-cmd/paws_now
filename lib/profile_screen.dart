import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de plimbări (aceeași din ecranul de istoric pentru consistența datelor)
    final List<Map<String, String>> pastWalks = [
      {
        'dogName': 'Rex',
        'date': '18 Octombrie 2026',
        'duration': '45 min',
        'price': '30 RON',
        'status': 'Finalizată',
      },
      {
        'dogName': 'Bella',
        'date': '15 Octombrie 2026',
        'duration': '60 min',
        'price': '40 RON',
        'status': 'Finalizată',
      },
      {
        'dogName': 'Max',
        'date': '10 Octombrie 2026',
        'duration': '30 min',
        'price': '25 RON',
        'status': 'Anulată',
      },
    ];

    // Calculăm dinamic suma totală doar pentru plimbările cu statusul 'Finalizată'
    int totalEarnings = 0;
    int completedWalksCount = 0;

    for (var walk in pastWalks) {
      if (walk['status'] == 'Finalizată') {
        completedWalksCount++;
        // Extragem doar numărul din șirul "30 RON"
        final priceString = walk['price']!.replaceAll(' RON', '');
        final priceInt = int.tryParse(priceString) ?? 0;
        totalEarnings += priceInt;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilul Meu'),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(Icons.account_circle, size: 100, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Utilizator PawsNow',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Cardul cu Statistici și Câștiguri Totale Calculate Dinamic
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$completedWalksCount',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 4),
                        const Text('Plimbări', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$totalEarnings RON',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 4),
                        const Text('Câștigat Total', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Ieși din cont'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
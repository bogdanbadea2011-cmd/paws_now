import 'package:flutter/material.dart';
import 'walk_details_screen.dart'; // Importăm ecranul de detalii

class WalkerHomeScreen extends StatelessWidget {
  const WalkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paws Now - Dog Walker'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Câini disponibili în zonă',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Cardul 1: Rex
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () {
                  // Deschide detaliile pentru Rex
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WalkDetailsScreen(
                        dogName: 'Rex',
                        ownerName: 'Andrei',
                        reward: '30 RON',
                        duration: '45 min',
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.pets, size: 40, color: Colors.orange),
                title: const Text('Rex (Proprietar: Andrei)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: const Text('Plimbare de 45 min • 30 RON • Distanță: 500m'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            
            // Cardul 2: Bella
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () {
                  // Deschide detaliile pentru Bella
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WalkDetailsScreen(
                        dogName: 'Bella',
                        ownerName: 'Ioana',
                        reward: '40 RON',
                        duration: '60 min',
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.pets, size: 40, color: Colors.brown),
                title: const Text('Bella (Proprietar: Ioana)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: const Text('Plimbare de 60 min • 40 RON • Distanță: 1.2km'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
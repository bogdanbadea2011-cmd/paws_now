import 'package:flutter/material.dart';

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
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.pets, size: 40, color: Colors.orange),
                title: Text('Rex (Proprietar: Andrei)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text('Plimbare de 45 min • 30 RON • Distanță: 500m'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.pets, size: 40, color: Colors.brown),
                title: Text('Bella (Proprietar: Ioana)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text('Plimbare de 60 min • 40 RON • Distanță: 1.2km'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
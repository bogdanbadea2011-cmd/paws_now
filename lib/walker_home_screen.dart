import 'package:flutter/material.dart';
import 'walk_details_screen.dart';

class WalkerHomeScreen extends StatefulWidget {
  const WalkerHomeScreen({super.key});

  @override
  State<WalkerHomeScreen> createState() => _WalkerHomeScreenState();
}

class _WalkerHomeScreenState extends State<WalkerHomeScreen> {
  final List<Map<String, String>> _dogsInArea = [
    {
      'dogName': 'Rex',
      'ownerName': 'Andrei',
      'duration': '45 min',
      'price': '30 RON',
      'distance': '500m',
    },
    {
      'dogName': 'Bella',
      'ownerName': 'Ioana',
      'duration': '60 min',
      'price': '40 RON',
      'distance': '1.2km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paws Now - Dog Walker',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Câini disponibili în zonă',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _dogsInArea.length,
                itemBuilder: (context, index) {
                  final dog = _dogsInArea[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: const Icon(Icons.pets, color: Colors.orange),
                      ),
                      title: Text(
                        '${dog['dogName']} (Proprietar: ${dog['ownerName']})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Plimbare de ${dog['duration']} • ${dog['price']} • Distanță: ${dog['distance']}',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalkDetailsScreen(
                              dogName: dog['dogName']!,
                              ownerName: dog['ownerName']!,
                              duration: dog['duration']!,
                              price: dog['price']!,
                              distance: dog['distance']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
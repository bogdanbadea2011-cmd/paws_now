import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pastWalks.length,
          itemBuilder: (context, index) {
            final walk = pastWalks[index];
            final isCanceled = walk['status'] == 'Anulată';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isCanceled ? Colors.red.shade100 : Colors.blueGrey.shade100,
                  child: Icon(
                    Icons.check_circle,
                    color: isCanceled ? Colors.red : Colors.blueGrey,
                  ),
                ),
                title: Text(
                  'Plimbare cu ${walk['dogName']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Data: ${walk['date']}'),
                    Text('Durată: ${walk['duration']} • Status: ${walk['status']}'),
                  ],
                ),
                trailing: Text(
                  walk['price']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isCanceled ? Colors.grey : Colors.green,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'add_dog_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  // Lista inițială care conține doar pe Rex. Aici se vor adăuga cățeii noi!
  final List<Map<String, String>> myDogs = [
    {'name': 'Rex', 'breed': 'Golden Retriever', 'age': '2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paws Now - Proprietar'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cățeii tăi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Această secțiune generează automat carduri pentru fiecare cățel din listă
            Expanded(
              child: ListView.builder(
                itemCount: myDogs.length,
                itemBuilder: (context, index) {
                  final dog = myDogs[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.pets, size: 40, color: Colors.orange),
                      title: Text(dog['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text('${dog['breed']} • ${dog['age']} ani'),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Căutare plimbători în zonă...')),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Caută un Plimbător'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () async {
          // Deschem ecranul de adăugare și așteptăm să primim datele noului cățel
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDogScreen()),
          );

          // Dacă utilizatorul a salvat un cățel, îl adăugăm în listă și împrospătăm ecranul
          if (result != null && result is Map<String, String>) {
            setState(() {
              myDogs.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
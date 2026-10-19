import 'package:flutter/material.dart';
import 'add_dog_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> myDogs = [
    {
      'name': 'Max',
      'breed': 'Golden Retriever',
      'age': '2 ani',
    },
    {
      'name': 'Luna',
      'breed': 'Beagle',
      'age': '1 an',
    },
  ];

  Future<void> _navigateAndAddDog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDogScreen()),
    );

    // Rezolvarea avertismentului: Verificăm dacă ecranul mai este activ în aplicație
    if (!mounted) return;

    if (result != null && result is Map<String, String>) {
      setState(() {
        myDogs.add(result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${result['name']} a fost adăugat în listă!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_currentIndex == 1) {
      bodyContent = const HistoryScreen();
    } else if (_currentIndex == 2) {
      bodyContent = const ProfileScreen();
    } else {
      bodyContent = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cățeii tăi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              myDogs.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('Nu ai adăugat niciun cățel încă.'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myDogs.length,
                      itemBuilder: (context, index) {
                        final dog = myDogs[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: const Icon(Icons.pets, color: Colors.orange),
                            ),
                            title: Text(
                              dog['name']!,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${dog['breed']} • ${dog['age']}'),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Solicitare trimisă pentru ${dog['name']}!')),
                                );
                              },
                              child: const Text('Solicită Plimbare'),
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Adaugă un cățel nou'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _navigateAndAddDog,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 
              ? 'PawsNow - Proprietar' 
              : _currentIndex == 1 
                  ? 'Istoric Plimbări' 
                  : 'Profilul Meu',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: true,
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acasă'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Istoric'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Lista dinamică de căței
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
    {
      'name': 'Oscar',
      'breed': 'Pug',
      'age': '3 ani',
    },
  ];

  Future<void> _navigateAndAddDog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDogScreen()),
    );

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_currentIndex == 1) {
      bodyContent = const HistoryScreen();
    } else if (_currentIndex == 2) {
      bodyContent = const ProfileScreen();
    } else {
      final filteredDogs = myDogs.where((dog) {
        final name = dog['name']!.toLowerCase();
        final breed = dog['breed']!.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || breed.contains(query);
      }).toList();

      bodyContent = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Caută după numele sau rasa cățelului...',
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.orange, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Cățeii tăi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 16),

              filteredDogs.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            Text(
                              _searchQuery.isEmpty 
                                  ? 'Nu ai adăugat niciun cățel încă.' 
                                  : 'Nu s-a găsit niciun rezultat pentru "$_searchQuery"',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredDogs.length,
                      itemBuilder: (context, index) {
                        final dog = filteredDogs[index];
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
                            // Secțiunea din dreapta unde punem ambele butoane în siguranță
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Solicitare trimisă pentru ${dog['name']}!')),
                                    );
                                  },
                                  child: const Text('Solicită'),
                                ),
                                const SizedBox(width: 4),
                                // Coșul de gunoi roșu pentru ștergere live
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      // Găsim indexul real al cățelului în lista originală pentru a-l șterge corect
                                      myDogs.removeWhere((element) => element['name'] == dog['name']);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${dog['name']} a fost șters.')),
                                    );
                                  },
                                ),
                              ],
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
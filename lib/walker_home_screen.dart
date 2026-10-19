import 'package:flutter/material.dart';
import 'walk_details_screen.dart';
import 'history_screen.dart'; 
import 'profile_screen.dart'; 

class WalkerHomeScreen extends StatefulWidget {
  const WalkerHomeScreen({super.key});

  @override
  State<WalkerHomeScreen> createState() => _WalkerHomeScreenState();
}

class _WalkerHomeScreenState extends State<WalkerHomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSize = 'Toți'; 

  final List<Map<String, String>> _allDogs = [
    {
      'dogName': 'Rex',
      'breed': 'Ciobănesc German',
      'ownerName': 'Andrei',
      'duration': '45 min',
      'price': '30 RON',
      'distance': '500m',
      'size': 'Mare',
    },
    {
      'dogName': 'Bella',
      'breed': 'Beagle',
      'ownerName': 'Ioana',
      'duration': '60 min',
      'price': '40 RON',
      'distance': '1.2km',
      'size': 'Mediu',
    },
    {
      'dogName': 'Papi',
      'breed': 'Chihuahua',
      'ownerName': 'Elena',
      'duration': '30 min',
      'price': '25 RON',
      'distance': '300m',
      'size': 'Mic',
    },
    {
      'dogName': 'Max',
      'breed': 'Rotweiler',
      'ownerName': 'Mihai',
      'duration': '50 min',
      'price': '35 RON',
      'distance': '800m',
      'size': 'Mare',
    },
  ];

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
      final filteredDogs = _allDogs.where((dog) {
        final name = dog['dogName']!.toLowerCase();
        final breed = dog['breed']!.toLowerCase();
        final query = _searchQuery.toLowerCase();
        final matchesQuery = name.contains(query) || breed.contains(query);
        final matchesSize = _selectedSize == 'Toți' || dog['size'] == _selectedSize;
        return matchesQuery && matchesSize;
      }).toList();

      bodyContent = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Caută după nume sau rasă...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
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
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Toți', 'Mic', 'Mediu', 'Mare'].map((size) {
                final isSelected = _selectedSize == size;
                return ChoiceChip(
                  label: Text(size),
                  selected: isSelected,
                  selectedColor: Colors.green.shade400,
                  // Corectat eroarea de stilizare a textului de la linia 132
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedSize = selected ? size : 'Toți';
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Câini disponibili în apropiere',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            
            Expanded(
              child: filteredDogs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'Nu am găsit niciun cățel cu aceste filtre.',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredDogs.length,
                      itemBuilder: (context, index) {
                        final dog = filteredDogs[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: const Icon(Icons.pets, color: Colors.orange),
                            ),
                            title: Text(
                              '${dog['dogName']} (${dog['breed']})',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('Talie: ${dog['size']} • Distanță: ${dog['distance']}'),
                                Text('Durată: ${dog['duration']} • Preț: ${dog['price']}'),
                              ],
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 
              ? 'Paws Now - Dog Walker' 
              : _currentIndex == 1 
                  ? 'Istoric Activitate' 
                  : 'Profil',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: true,
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
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
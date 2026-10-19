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

  // Lista completă de câini disponibili în zonă
  final List<Map<String, String>> _allDogs = [
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
    {
      'dogName': 'Max',
      'ownerName': 'Mihai',
      'duration': '30 min',
      'price': '25 RON',
      'distance': '800m',
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
      // Filtrarea dinamică a listei în funcție de textul introdus în bara de căutare
      final filteredDogs = _allDogs.where((dog) {
        final name = dog['dogName']!.toLowerCase();
        final owner = dog['ownerName']!.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || owner.contains(query);
      }).toList();

      bodyContent = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Câmpul vizual de Căutare (Search Bar)
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Caută un cățel sau un proprietar...',
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Actualizează lista la fiecare literă tastată
                });
              },
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Câini disponibili în apropiere',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
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
                          Text(
                            'Nu am găsit niciun cățel pentru "$_searchQuery"',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
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
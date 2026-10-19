import 'package:flutter/material.dart';
import 'add_dog_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'payment_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> myDogs = [
    {
      'name': 'Max',
      'breed': 'Golden Retriever',
      'age': '2 ani',
      'price': '40',
    },
    {
      'name': 'Luna',
      'breed': 'Beagle',
      'age': '1 an',
      'price': '35',
    },
    {
      'name': 'Oscar',
      'breed': 'Pug',
      'age': '3 ani',
      'price': '30',
    },
  ];

  final Set<int> _selectedDogIndices = {};

  Future<void> _navigateAndAddDog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDogScreen()),
    );

    if (!mounted) return;

    if (result != null && result is Map<String, String>) {
      setState(() {
        myDogs.add({
          'name': result['name'] ?? 'Cățel',
          'breed': result['breed'] ?? 'Rasă mixtă',
          'age': result['age'] ?? 'Necunoscută',
          'price': '35',
        });
      });
      _showCustomNotification('Succes!', '${result['name'] ?? 'Cățelul'} a fost adăugat în listă.');
    }
  }

  void _showCustomNotification(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.notifications_active, color: Colors.orange),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Închide', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  double _calculateTotalCost() {
    double total = 0;
    for (int index in _selectedDogIndices) {
      if (index < myDogs.length) {
        total += double.tryParse(myDogs[index]['price']!) ?? 0;
      }
    }
    if (_selectedDogIndices.length > 1) {
      total = total * 0.9;
    }
    return total;
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

      bodyContent = Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      'Selectează cățeii pentru plimbare',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
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
                              final originalIndex = myDogs.indexOf(dog);
                              final isSelected = _selectedDogIndices.contains(originalIndex);

                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Checkbox(
                                    activeColor: Colors.orange,
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          _selectedDogIndices.add(originalIndex);
                                        } else {
                                          _selectedDogIndices.remove(originalIndex);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(
                                    dog['name']!,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('${dog['breed']} • ${dog['age']} • Tarif: ${dog['price']} RON'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _selectedDogIndices.remove(originalIndex);
                                        myDogs.removeAt(originalIndex);
                                      });
                                      _showCustomNotification('Ștergere', '${dog['name']} a fost eliminat din cont.');
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 16),
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
            ),
          ),
          if (_selectedDogIndices.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${_selectedDogIndices.length} cățel(i) selectat(i)'),
                        Text(
                          'Total: ${_calculateTotalCost().toStringAsFixed(2)} RON',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentScreen(amount: '',)),
                      );
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text('Continuă'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paws Now'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acasă'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Istoric'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
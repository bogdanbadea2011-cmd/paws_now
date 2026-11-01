import 'package:flutter/material.dart';

class PetSitterScreen extends StatefulWidget {
  const PetSitterScreen({super.key});

  @override
  State<PetSitterScreen> createState() => _PetSitterScreenState();
}

class _PetSitterScreenState extends State<PetSitterScreen> {
  DateTimeRange? _selectedDateRange;

  // Funcție care deschide calendarul pentru selectarea perioadei de vacanță
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      currentDate: DateTime.now(),
      saveText: 'Selectează',
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Găsește Pet Sitter (Vacanță)'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 📅 ZONA 1: Selectorul pentru perioada vacanței
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateRange == null
                        ? 'Alege perioada vacanței'
                        : 'Perioadă: ${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _selectDateRange(context),
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('Calendar'),
                ),
              ],
            ),
          ),

          // 🗺️ ZONA 2: Locul unde vom afișa harta Google Maps
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map, size: 60, color: Colors.grey),
                    const SizedBox(height: 10),
                    const Text(
                      'Aici va fi încărcată harta cu sitteri',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Aici vom conecta Widget-ul tău existent de Google Maps
                      },
                      child: const Text('Încarcă Google Maps'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _historySearchController = TextEditingController();
  String _historyQuery = '';
  String _selectedStatusFilter = 'Toate'; // Filtru implicit

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
  void dispose() {
    _historySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Aplicăm dubla filtrare: după text ȘI după status
    final filteredHistory = pastWalks.where((walk) {
      final dogName = walk['dogName']!.toLowerCase();
      final query = _historyQuery.toLowerCase();
      final matchesQuery = dogName.contains(query);

      final matchesStatus = _selectedStatusFilter == 'Toate' || walk['status'] == _selectedStatusFilter;

      return matchesQuery && matchesStatus;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bara de căutare text
            TextField(
              controller: _historySearchController,
              decoration: InputDecoration(
                hintText: 'Caută în istoric după numele cățelului...',
                prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                suffixIcon: _historyQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _historySearchController.clear();
                            _historyQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _historyQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),

            // Filtre rapide (Chips) pentru Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Toate', 'Finalizată', 'Anulată'].map((status) {
                final isSelected = _selectedStatusFilter == status;
                return ChoiceChip(
                  label: Text(status),
                  selected: isSelected,
                  selectedColor: Colors.blueGrey.shade400,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedStatusFilter = selected ? status : 'Toate';
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Afișarea listei filtrate
            Expanded(
              child: filteredHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'Nu s-a găsit nicio plimbare corespunzătoare.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredHistory.length,
                      itemBuilder: (context, index) {
                        final walk = filteredHistory[index];
                        final isCanceled = walk['status'] == 'Anulată';

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
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
          ],
        ),
      ),
    );
  }
}
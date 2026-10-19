import 'package:flutter/material.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();

  // Pictograma implicită selectată pentru cățel
  IconData _selectedDogIcon = Icons.pets;

  // Listă de pictograme de căței disponibile pentru selectat rapid
  final List<IconData> _availableIcons = [
    Icons.pets,
    Icons.cruelty_free,
    Icons.catching_pokemon,
    Icons.face,
  ];

  void _saveDog() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text.trim(),
        'breed': _breedController.text.trim(),
        'age': _ageController.text.trim(),
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adaugă un Cățel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Previzualizare Avatar Cățel (se schimbă live!)
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange.shade100,
                  child: Icon(
                    _selectedDogIcon,
                    size: 50,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Selector de Avatar
              const Text(
                'Alege o pictogramă pentru profil:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _availableIcons.map((icon) {
                  final isSelected = _selectedDogIcon == icon;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDogIcon = icon; // Schimbă avatarul de sus pe loc!
                        });
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: isSelected ? Colors.orange : Colors.grey.shade200,
                        child: Icon(
                          icon,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Câmpuri Formular
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Numele cățelului',
                  prefixIcon: const Icon(Icons.edit, color: Colors.orange),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Introdu un nume' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(
                  labelText: 'Rasă (ex: Golden Retriever)',
                  prefixIcon: const Icon(Icons.dns, color: Colors.orange),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Introdu rasa' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Vârstă (ex: 2 ani)',
                  prefixIcon: const Icon(Icons.cake, color: Colors.orange),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Introdu vârsta' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _saveDog,
                child: const Text(
                  'Salvează Cățelul',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
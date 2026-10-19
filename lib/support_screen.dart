import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  void _submitTicket() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text('Mesaj Trimis', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text('Echipa PawsNow a preluat solicitarea ta și îți va răspunde prin email în cel mai scurt timp.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _messageController.clear();
              },
              child: const Text('Ok', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suport & Ajutor',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Întrebări Frecvente (FAQ)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ExpansionTile(
                title: Text('Cum sunt plătit ca Dog Walker?', style: TextStyle(fontWeight: FontWeight.w500)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Plata se transferă automat în portofelul tău digital din aplicație imediat ce proprietarul confirmă finalizarea plimbării.'),
                  )
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ExpansionTile(
                title: Text('Ce fac în caz de urgență?', style: TextStyle(fontWeight: FontWeight.w500)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Folosește butonul de chat pentru a contacta imediat proprietarul sau apelează numărul de urgență afișat în detaliile plimbării.'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Trimite-ne un mesaj',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Descrie problema sau întrebarea ta aici...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                    ),
                    validator: (value) => (value == null || value.trim().isEmpty) ? 'Te rugăm să scrii un mesaj înainte de a trimite.' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Trimite Solicitare'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _submitTicket,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
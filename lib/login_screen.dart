import 'package:flutter/material.dart';
import 'walker_home_screen.dart';
import 'owner_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _navigateToHome(bool isWalker) {
    // Validăm formularul înainte de a schimba ecranul
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isWalker ? const WalkerHomeScreen() : const OwnerHomeScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey, // Legăm cheia globală pentru validare
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.pets, size: 80, color: Colors.orange),
                const SizedBox(height: 16),
                const Text(
                  'PawsNow',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const Text(
                  'Aplicația ta pentru plimbat căței',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Câmp Email cu Validare Avansată
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email, color: Colors.orange),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Te rugăm să introduci o adresă de email';
                    }
                    // Expresie regulată (RegEx) pentru a verifica formatul corect de email
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Te rugăm să introduci un email valid (ex: nume@email.com)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Câmp Parolă cu Validare de Lungime
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Parolă',
                    prefixIcon: const Icon(Icons.lock, color: Colors.orange),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rugăm să introduci parola';
                    }
                    if (value.length < 6) {
                      return 'Parola trebuie să aibă minimum 6 caractere';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Buton Autentificare ca Walker
                ElevatedButton.icon(
                  icon: const Icon(Icons.directions_walk),
                  label: const Text('Intră ca Walker (Plimbător)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _navigateToHome(true),
                ),
                const SizedBox(height: 12),

                // Buton Autentificare ca Owner
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Intră ca Owner (Proprietar)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _navigateToHome(false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
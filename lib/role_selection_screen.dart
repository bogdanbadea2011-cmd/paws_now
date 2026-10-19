import 'package:flutter/material.dart';
import 'owner_home_screen.dart';
import 'walker_home_screen.dart'; // Importăm noul ecran pentru plimbător

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerHomeScreen()),
                );
              },
              child: const Text('Am un câine (Caut plimbător)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigăm către ecranul plimbătorului
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalkerHomeScreen()),
                );
              },
              child: const Text('Sunt Dog Walker (Vreau să plimb)'),
            ),
          ],
        ),
      ),
    );
  }
}
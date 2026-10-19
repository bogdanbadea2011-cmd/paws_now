import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'chat_screen.dart';

class WalkDetailsScreen extends StatefulWidget {
  final String dogName;
  final String ownerName;
  final String duration;
  final String price;
  final String distance;

  const WalkDetailsScreen({
    super.key,
    this.dogName = 'Rex',
    this.ownerName = 'Andrei',
    this.duration = '45 min',
    this.price = '30 RON',
    this.distance = '500m',
  });

  @override
  State<WalkDetailsScreen> createState() => _WalkDetailsScreenState();
}

class _WalkDetailsScreenState extends State<WalkDetailsScreen> {
  Timer? _timer;
  int _secondsPassed = 0;
  bool _isWalkingActive = false;
  double _kilometersWalked = 0.0;

  // Controllerul pentru gestionarea hărții Google active
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  // Coordonatele inițiale (Centrul Bucureștiului - Piața Universității)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(44.4355, 26.1025),
    zoom: 15.0,
  );

  // Set pentru memorarea markerului de poziție al cățelului
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Adăugăm markerul inițial pe hartă
    _markers.add(
      Marker(
        markerId: const MarkerId('dog_location'),
        position: _initialPosition.target,
        infoWindow: InfoWindow(title: 'Poziție ${widget.dogName}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    );
  }

  void _startWalk() {
    setState(() {
      _isWalkingActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsPassed++;
        if (_secondsPassed % 5 == 0) {
          _kilometersWalked += 0.01;
        }
      });
    });
  }

  void _stopWalk() {
    _timer?.cancel();
    setState(() {
      _isWalkingActive = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Plimbare Finalizată! 🎉', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          'Ai plimbat-o pe ${widget.dogName} timp de ${_formatTime(_secondsPassed)} '
          'și ai parcurs ${_kilometersWalked.toStringAsFixed(2)} km.\n\n'
          'Suma de ${widget.price} a fost transferată în contul tău.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Ok', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalii Plimbare - ${widget.dogName}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    chatWith: '${widget.ownerName} (Proprietar)',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card Detalii Cățel
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.green.shade100,
                      child: const Icon(Icons.pets, size: 35, color: Colors.green),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.dogName,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Proprietar: ${widget.ownerName}',
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    const Divider(height: 24, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoColumn(Icons.access_time, 'Țintă', widget.duration),
                        _buildInfoColumn(Icons.monetization_on, 'Plată', widget.price),
                        _buildInfoColumn(Icons.location_on, 'Distanță', widget.distance),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // NOU: COMPONENTA HĂRȚII REALE GOOGLE MAPS
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card Monitorizare Plimbare Activă
            Card(
              color: _isWalkingActive ? Colors.green.shade50 : Colors.grey.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      _isWalkingActive ? 'PLIMBARE ACTIVĂ' : 'CRONOMETRU INACTIV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isWalkingActive ? Colors.green : Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTime(_secondsPassed),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Distanță parcursă: ${_kilometersWalked.toStringAsFixed(2)} km',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: Icon(_isWalkingActive ? Icons.stop : Icons.play_arrow),
              label: Text(_isWalkingActive ? 'Finalizează Plimbarea' : 'Acceptă și Începe'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isWalkingActive ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: _isWalkingActive ? _stopWalk : _startWalk,
            ),
          ],
        ),
      ),
    );
  }
}
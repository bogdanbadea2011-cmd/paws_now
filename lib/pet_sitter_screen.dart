import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetSitterScreen extends StatefulWidget {
  const PetSitterScreen({super.key});

  @override
  State<PetSitterScreen> createState() => _PetSitterScreenState();
}

class _PetSitterScreenState extends State<PetSitterScreen> {
  DateTimeRange? _selectedDateRange;
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  // Coordonatele inițiale (Centrul Bucureștiului) identice cu cele din proiectul tău
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(44.4355, 26.1025),
    zoom: 14.0,
  );

  // Funcție pentru deschiderea calendarului
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
          // Selectorul perioadei de vacanță
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
          
          // Harta reală Google Maps
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
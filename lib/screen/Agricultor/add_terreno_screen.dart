// lib/screens/add_terreno_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart'; // Añade esta línea
import 'package:latlong2/latlong.dart';
import 'package:agro_link/models/Agricultor/terreno.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:geocoding/geocoding.dart';

class AddTerrenoScreen extends StatefulWidget {
  final int idAgricultor;
  final Function(Terreno) onSave;

  const AddTerrenoScreen({Key? key, required this.idAgricultor, required this.onSave}) : super(key: key);

  @override
  _AddTerrenoScreenState createState() => _AddTerrenoScreenState();
}

class _AddTerrenoScreenState extends State<AddTerrenoScreen> {
  final TextEditingController areaController = TextEditingController();
  final TextEditingController superficieTotalController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final ApiService _apiService = ApiService();

  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  void _saveTerreno() async {
    final area = double.tryParse(areaController.text.trim());
    final superficieTotal = double.tryParse(superficieTotalController.text.trim());
    final ubicacion = ubicacionController.text.trim();
    final descripcion = descripcionController.text.trim();

    if (_selectedLocation != null && area != null && superficieTotal != null && descripcion.isNotEmpty) {
      final terrenoData = {
        'id_agricultor': widget.idAgricultor,
        'ubicacion_latitud': _selectedLocation!.latitude,
        'ubicacion_longitud': _selectedLocation!.longitude,
        'ubicacion': ubicacion,
        'area': area,
        'superficie_total': superficieTotal,
        'descripcion': descripcion,
      };

      try {
        await _apiService.createLand(terrenoData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terreno añadido con éxito')),
        );
        widget.onSave(Terreno.fromJson(terrenoData));
        Navigator.pop(context, true);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al añadir el terreno: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos correctamente.')),
      );
    }
  }

  void _onTapMap(LatLng latLng) {
    setState(() {
      _selectedLocation = latLng;
    });
    _getAddressFromLatLng(latLng);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          ubicacionController.text = '${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}';
        });
      }
    } catch (e) {
      debugPrint('Error al obtener la dirección: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialLocation = LatLng(-16.290154, -63.588653); // Coordenadas de Bolivia
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Terreno'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: initialLocation,
                zoom: 5.0,
                onTap: (tapPosition, latLng) => _onTapMap(latLng),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.agro_link',
                ),
                if (_selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _selectedLocation!,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTextField(areaController, 'Área (ha)', Icons.square_foot, isNumeric: true),
                _buildTextField(superficieTotalController, 'Superficie Total (ha)', Icons.square_foot, isNumeric: true),
                _buildTextField(ubicacionController, 'Ubicación', Icons.map),
                _buildTextField(descripcionController, 'Descripción', Icons.description),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveTerreno,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Añadir Terreno', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green.shade400),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
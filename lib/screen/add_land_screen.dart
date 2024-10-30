// lib/screens/add_land_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/cultivos/land.dart';

class AddLandScreen extends StatefulWidget {
  final Land? land;
  final Function(Land) onSave;

  AddLandScreen({this.land, required this.onSave});

  @override
  _AddLandScreenState createState() => _AddLandScreenState();
}

class _AddLandScreenState extends State<AddLandScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController cropController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.land != null) {
      nameController.text = widget.land!.name;
      locationController.text = widget.land!.location;
      sizeController.text = widget.land!.size.toString();
      cropController.text = widget.land!.crop;
    }
  }

  void saveLand() {
    final name = nameController.text;
    final location = locationController.text;
    final size = double.tryParse(sizeController.text) ?? 0;
    final crop = cropController.text;

    if (name.isNotEmpty && location.isNotEmpty && size > 0 && crop.isNotEmpty) {
      final land = Land(name: name, location: location, size: size, crop: crop);
      widget.onSave(land);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, completa todos los campos correctamente.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.land != null ? 'Editar Terreno' : 'Añadir Terreno', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nameController, 'Nombre del Terreno', Icons.landscape),
            SizedBox(height: 16),
            _buildTextField(locationController, 'Ubicación', Icons.location_on),
            SizedBox(height: 16),
            _buildTextField(sizeController, 'Tamaño (ha)', Icons.square_foot, isNumeric: true),
            SizedBox(height: 16),
            _buildTextField(cropController, 'Cultivo', Icons.eco),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: saveLand,
              child: Text(widget.land != null ? 'Guardar Cambios' : 'Añadir Terreno', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green.shade400),
        filled: true,
        fillColor: Colors.green.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}

// lib/screens/add_produccion_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/produccion.dart';
import 'package:agro_link/services/api_service.dart';

class AddProduccionScreen extends StatefulWidget {
  final Function(Produccion) onSave;

  const AddProduccionScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  AddProduccionScreenState createState() => AddProduccionScreenState();
}

class AddProduccionScreenState extends State<AddProduccionScreen> {
  final TextEditingController _idTerrenoController = TextEditingController();
  final TextEditingController _idTemporadaController = TextEditingController();
  final TextEditingController _idProductoController = TextEditingController();
  final TextEditingController _cantidadDisponibleController = TextEditingController();
  final TextEditingController _fechaRecoleccionController = TextEditingController();

  final ApiService apiService = ApiService();

  void _saveProduccion() async {
    final idTerreno = int.tryParse(_idTerrenoController.text.trim());
    final idTemporada = int.tryParse(_idTemporadaController.text.trim());
    final idProducto = int.tryParse(_idProductoController.text.trim());
    final cantidadDisponible = int.tryParse(_cantidadDisponibleController.text.trim());
    final fechaRecoleccion = _fechaRecoleccionController.text.trim();

    if (idTerreno != null &&
        idTemporada != null &&
        idProducto != null &&
        cantidadDisponible != null &&
        fechaRecoleccion.isNotEmpty) {
      final produccionData = {
        'id_terreno': idTerreno,
        'id_temporada': idTemporada,
        'id_producto': idProducto,
        'cantidad_disponible': cantidadDisponible,
        'fecha_recoleccion': fechaRecoleccion,
      };
      try {
        await apiService.createProduccion(produccionData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producción creada con éxito')),
        );
        widget.onSave(Produccion(
          idTerreno: idTerreno,
          idTemporada: idTemporada,
          idProducto: idProducto,
          cantidadDisponible: cantidadDisponible,
          fechaRecoleccion: fechaRecoleccion,
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la producción')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _fechaRecoleccionController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Producción'),
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_idTerrenoController, 'ID de Terreno'),
            _buildTextField(_idTemporadaController, 'ID de Temporada'),
            _buildTextField(_idProductoController, 'ID de Producto'),
            _buildTextField(_cantidadDisponibleController, 'Cantidad Disponible'),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _fechaRecoleccionController,
                  decoration: const InputDecoration(labelText: 'Fecha de Recolección'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduccion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

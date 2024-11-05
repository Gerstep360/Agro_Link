// lib/screens/add_cliente_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/cliente.dart';
import 'package:agro_link/services/api_service.dart';

class AddClienteScreen extends StatefulWidget {
  final Function(Cliente) onSave;

  const AddClienteScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  AddClienteScreenState createState() => AddClienteScreenState();
}

class AddClienteScreenState extends State<AddClienteScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ubicacionLatitudController = TextEditingController();
  final TextEditingController _ubicacionLongitudController = TextEditingController();

  final ApiService apiService = ApiService();

  void _saveCliente() async {
    final nombre = _nombreController.text.trim();
    final apellido = _apellidoController.text.trim();
    final email = _emailController.text.trim();
    final telefono = _telefonoController.text.trim();
    final direccion = _direccionController.text.trim();
    final ubicacionLatitud = _ubicacionLatitudController.text.trim();
    final ubicacionLongitud = _ubicacionLongitudController.text.trim();

    if (nombre.isNotEmpty &&
        apellido.isNotEmpty &&
        email.isNotEmpty &&
        telefono.isNotEmpty &&
        direccion.isNotEmpty &&
        ubicacionLatitud.isNotEmpty &&
        ubicacionLongitud.isNotEmpty) {
      final clienteData = {
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'telefono': telefono,
        'direccion': direccion,
        'ubicacion_latitud': ubicacionLatitud,
        'ubicacion_longitud': ubicacionLongitud,
      };
      try {
        await apiService.createCliente(clienteData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente creado con éxito')),
        );
        widget.onSave(Cliente(
          nombre: nombre,
          apellido: apellido,
          email: email,
          telefono: telefono,
          direccion: direccion,
          ubicacionLatitud: ubicacionLatitud,
          ubicacionLongitud: ubicacionLongitud,
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear el cliente')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Cliente'),
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nombreController, 'Nombre'),
            _buildTextField(_apellidoController, 'Apellido'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_telefonoController, 'Teléfono'),
            _buildTextField(_direccionController, 'Dirección'),
            _buildTextField(_ubicacionLatitudController, 'Ubicación Latitud'),
            _buildTextField(_ubicacionLongitudController, 'Ubicación Longitud'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCliente,
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
      ),
    );
  }
}

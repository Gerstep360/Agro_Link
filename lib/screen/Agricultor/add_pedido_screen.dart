// lib/screens/add_pedido_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/pedido.dart';
import 'package:agro_link/services/api_service.dart';

class AddPedidoScreen extends StatefulWidget {
  final Function(Pedido) onSave;

  const AddPedidoScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  AddPedidoScreenState createState() => AddPedidoScreenState();
}

class AddPedidoScreenState extends State<AddPedidoScreen> {
  final TextEditingController _idClienteController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _fechaEntregaController = TextEditingController();

  final ApiService apiService = ApiService();

  void _savePedido() async {
    final idCliente = int.tryParse(_idClienteController.text.trim());
    final estado = _estadoController.text.trim();
    final fechaEntrega = _fechaEntregaController.text.trim();

    if (idCliente != null && estado.isNotEmpty && fechaEntrega.isNotEmpty) {
      final pedidoData = {
        'id_cliente': idCliente,
        'estado': estado,
        'fecha_entrega': fechaEntrega,
      };
      try {
        await apiService.createPedido(pedidoData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido creado con éxito')),
        );
        widget.onSave(Pedido(
          idCliente: idCliente,
          estado: estado,
          fechaEntrega: fechaEntrega,
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear el pedido')),
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
        _fechaEntregaController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Pedido'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_idClienteController, 'ID de Cliente'),
            _buildTextField(_estadoController, 'Estado'),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _fechaEntregaController,
                  decoration: const InputDecoration(labelText: 'Fecha de Entrega'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePedido,
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
        keyboardType: label.contains('ID') ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}

// lib/screens/add_oferta_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/agricultor/oferta.dart';
import 'package:agro_link/services/api_service.dart';

class AddOfertaScreen extends StatefulWidget {
  final void Function(Oferta) onSave;

  const AddOfertaScreen({super.key, required this.onSave});

  @override
  AddOfertaScreenState createState() => AddOfertaScreenState();
}

class AddOfertaScreenState extends State<AddOfertaScreen> {
  final TextEditingController _idProduccionController = TextEditingController();
  final TextEditingController _idAgricultorController = TextEditingController();
  final TextEditingController _precioOfertaController = TextEditingController();
  final TextEditingController _cantidadOfertaController = TextEditingController();
  final ApiService apiService = ApiService();

  void _saveOferta() async {
    final idProduccion = int.tryParse(_idProduccionController.text.trim());
    final idAgricultor = int.tryParse(_idAgricultorController.text.trim());
    final precioOferta = double.tryParse(_precioOfertaController.text.trim());
    final cantidadOferta = int.tryParse(_cantidadOfertaController.text.trim());

    if (idProduccion != null && idAgricultor != null && precioOferta != null && cantidadOferta != null) {
      final ofertaData = {
        'id_produccion': idProduccion,
        'id_agricultor': idAgricultor,
        'precio_oferta': precioOferta,
        'cantidad_oferta': cantidadOferta,
      };
      try {
        await apiService.createOferta(ofertaData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oferta creada con éxito')),
        );
        widget.onSave(Oferta(
          idProduccion: idProduccion,
          idAgricultor: idAgricultor,
          precioOferta: precioOferta,
          cantidadOferta: cantidadOferta,
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la oferta')),
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
        title: const Text('Añadir Oferta'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idProduccionController,
              decoration: const InputDecoration(
                labelText: 'ID de Producción',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _idAgricultorController,
              decoration: const InputDecoration(
                labelText: 'ID de Agricultor',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _precioOfertaController,
              decoration: const InputDecoration(
                labelText: 'Precio de la Oferta',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _cantidadOfertaController,
              decoration: const InputDecoration(
                labelText: 'Cantidad de la Oferta',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveOferta,
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
}

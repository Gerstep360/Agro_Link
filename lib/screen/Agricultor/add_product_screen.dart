// lib/screens/add_product_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/producto.dart';
import 'package:agro_link/services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Producto) onSave;

  const AddProductScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _idCategoriaController = TextEditingController();
  final ApiService apiService = ApiService();

  void _saveProduct() async {
    final nombre = _nombreController.text.trim();
    final descripcion = _descripcionController.text.trim();
    final idCategoria = int.tryParse(_idCategoriaController.text.trim());

    if (nombre.isNotEmpty && descripcion.isNotEmpty && idCategoria != null) {
      final productData = {
        'nombre': nombre,
        'descripcion': descripcion,
        'id_categoria': idCategoria,
      };
      try {
        await apiService.createProducto(productData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto creado con éxito')),
        );
        widget.onSave(Producto(
          nombre: nombre,
          descripcion: descripcion,
          idCategoria: idCategoria,
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear el producto')),
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
        title: const Text('Añadir Producto'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
              ),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            TextField(
              controller: _idCategoriaController,
              decoration: const InputDecoration(
                labelText: 'ID de la categoría',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
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

// ignore: file_names
// lib/screens/add_category_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/agricultor/categoria.dart';
import 'package:agro_link/services/api_service.dart';

class AddCategoryScreen extends StatefulWidget {
  final void Function(Category) onSave; // Cambia Function a void Function

  const AddCategoryScreen({super.key, required this.onSave});

  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ApiService apiService = ApiService();

  void _saveCategory() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final categoryData = {'nombre': name};
      try {
        await apiService.createCategoria(categoryData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Categoría creada con éxito')),
        );
        widget.onSave(Category(nombre: name));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la categoría')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre no puede estar vacío')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Categoría'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la categoría',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCategory,
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

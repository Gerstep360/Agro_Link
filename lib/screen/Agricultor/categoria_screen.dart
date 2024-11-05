// lib/screens/categoria_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/añadir_categoria.dart';
import 'package:agro_link/models/agricultor/categoria.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService apiService = ApiService();
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final data = await apiService.fetchCategorias();
      setState(() {
        categories = data.map((catData) => Category.fromJson(catData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar categorías: $e');
    }
  }

  void _addCategory(Category category) {
    setState(() {
      categories.add(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.nombre),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newCategory = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryScreen(onSave: _addCategory),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

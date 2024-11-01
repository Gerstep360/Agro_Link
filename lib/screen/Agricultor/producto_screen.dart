// lib/screens/producto_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/producto.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/add_product_screen.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  ProductosScreenState createState() => ProductosScreenState();
}

class ProductosScreenState extends State<ProductosScreen> {
  final ApiService apiService = ApiService();
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    _fetchProductos();
  }

  Future<void> _fetchProductos() async {
    try {
      final data = await apiService.fetchProductos();
      setState(() {
        productos =
            data.map((prodData) => Producto.fromJson(prodData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar productos: $e');
    }
  }

  void _addProducto(Producto producto) {
    setState(() {
      productos.add(producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto.nombre),
            subtitle: Text(producto.descripcion),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newProducto = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(onSave: _addProducto),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

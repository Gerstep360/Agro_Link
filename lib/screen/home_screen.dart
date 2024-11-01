// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/terreno_screen.dart';
import 'package:agro_link/screen/Agricultor/producto_screen.dart';
import 'package:agro_link/screen/Agricultor/producciones_screen.dart';
import 'package:agro_link/screen/Agricultor/pedidos_screen.dart';
import 'package:agro_link/screen/Agricultor/ofertas_screen.dart';
import 'package:agro_link/screen/Agricultor/categoria_screen.dart';

class HomeScreen extends StatefulWidget {
  final int idAgricultor;

  const HomeScreen({Key? key, required this.idAgricultor}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String agricultorName = '';
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchAgricultorName();
  }

  Future<void> _fetchAgricultorName() async {
    try {
      final agricultores = await apiService.fetchAgricultores();
      final agricultor = agricultores.firstWhere(
        (ag) => ag['id'] == widget.idAgricultor,
        orElse: () => null,
      );
      if (agricultor != null) {
        setState(() {
          agricultorName = agricultor['nombre'];
        });
      } else {
        setState(() {
          agricultorName = 'Agricultor no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        agricultorName = 'Error al cargar agricultor';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $agricultorName'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.landscape, color: Colors.green.shade400),
            title: const Text('Terrenos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TerrenosScreen(idAgricultor: widget.idAgricultor),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket, color: Colors.green.shade400),
            title: const Text('Productos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductosScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.agriculture, color: Colors.green.shade400),
            title: const Text('Producciones'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProduccionesScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page, color: Colors.green.shade400),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PedidosScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_offer, color: Colors.green.shade400),
            title: const Text('Ofertas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OfertasScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.green.shade400),
            title: const Text('Categorías'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// lib/screens/terreno_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/terreno.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/add_terreno_screen.dart';

class TerrenosScreen extends StatefulWidget {
  final int idAgricultor;

  const TerrenosScreen({Key? key, required this.idAgricultor}) : super(key: key);

  @override
  _TerrenosScreenState createState() => _TerrenosScreenState();
}

class _TerrenosScreenState extends State<TerrenosScreen> {
  final ApiService _apiService = ApiService();
  List<Terreno> terrenos = [];

  @override
  void initState() {
    super.initState();
    _fetchTerrenos();
  }

  Future<void> _fetchTerrenos() async {
    try {
      final data = await _apiService.fetchLands(widget.idAgricultor);
      setState(() {
        terrenos = data.map((terrenoData) => Terreno.fromJson(terrenoData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar terrenos: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar terrenos: $e')),
      );
    }
  }

  void _addTerreno(Terreno terreno) {
    setState(() {
      terrenos.add(terreno);
    });
  }

  void _navigateToAddTerreno() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTerrenoScreen(
          idAgricultor: widget.idAgricultor,
          onSave: _addTerreno,
        ),
      ),
    );
    if (result != null && result == true) {
      _fetchTerrenos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terrenos'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: terrenos.length,
        itemBuilder: (context, index) {
          final terreno = terrenos[index];
          return ListTile(
            leading: const Icon(Icons.landscape),
            title: Text('Terreno ID: ${terreno.id}'),
            subtitle: Text('Área: ${terreno.area} ha\nUbicación: ${terreno.ubicacion}'),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: _navigateToAddTerreno,
        child: const Icon(Icons.add),
      ),
    );
  }
}

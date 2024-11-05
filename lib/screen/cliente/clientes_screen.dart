// lib/screens/clientes_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/cliente.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/cliente/add_cliente_screen.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({Key? key}) : super(key: key);

  @override
  ClientesScreenState createState() => ClientesScreenState();
}

class ClientesScreenState extends State<ClientesScreen> {
  final ApiService apiService = ApiService();
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    _fetchClientes();
  }

  Future<void> _fetchClientes() async {
    try {
      final data = await apiService.fetchClientes();
      setState(() {
        clientes = data.map((clienteData) => Cliente.fromJson(clienteData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar clientes: $e');
    }
  }

  void _addCliente(Cliente cliente) {
    setState(() {
      clientes.add(cliente);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          return ListTile(
            title: Text('${cliente.nombre} ${cliente.apellido}'),
            subtitle: Text(cliente.email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newCliente = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddClienteScreen(onSave: _addCliente),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

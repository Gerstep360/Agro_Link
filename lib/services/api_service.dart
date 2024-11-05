// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.100.169:8000/api';

  // 1. Agricultores
  Future<List<dynamic>> fetchAgricultores() async {
    final response = await http.get(Uri.parse('$_baseUrl/agricultores'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los agricultores');
    }
  }

  Future<String> createAgricultor(Map<String, dynamic> agricultorData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/agricultores'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agricultorData),
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['id'].toString();
    } else {
      throw Exception('Error al crear el agricultor');
    }
  }

  // 2. Categorías
  Future<List<dynamic>> fetchCategorias() async {
    final response = await http.get(Uri.parse('$_baseUrl/categorias'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }

  Future<void> createCategoria(Map<String, dynamic> categoriaData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/categorias'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoriaData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la categoría');
    }
  }

  // 3. Clientes
  Future<List<dynamic>> fetchClientes() async {
    final response = await http.get(Uri.parse('$_baseUrl/clientes'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los clientes');
    }
  }

  Future<void> createCliente(Map<String, dynamic> clienteData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/clientes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(clienteData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el cliente');
    }
  }

  // 4. Productos
  Future<List<dynamic>> fetchProductos() async {
    final response = await http.get(Uri.parse('$_baseUrl/productos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  Future<void> createProducto(Map<String, dynamic> productoData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/productos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productoData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el producto');
    }
  }

  // 5. Producciones
  Future<List<dynamic>> fetchProducciones() async {
    final response = await http.get(Uri.parse('$_baseUrl/producciones'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las producciones');
    }
  }

  Future<void> createProduccion(Map<String, dynamic> produccionData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/producciones'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produccionData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la producción');
    }
  }

  // 6. Pedidos
  Future<List<dynamic>> fetchPedidos() async {
    final response = await http.get(Uri.parse('$_baseUrl/pedidos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los pedidos');
    }
  }

  Future<void> createPedido(Map<String, dynamic> pedidoData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/pedidos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedidoData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el pedido');
    }
  }

  // 7. Detalles de Pedido
  Future<List<dynamic>> fetchPedidoDetalles() async {
    final response = await http.get(Uri.parse('$_baseUrl/pedido-detalles'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los detalles de pedidos');
    }
  }

  Future<void> createPedidoDetalle(Map<String, dynamic> detalleData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/pedido-detalles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(detalleData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el detalle de pedido');
    }
  }

  // 8. Ofertas
  Future<List<dynamic>> fetchOfertas() async {
    final response = await http.get(Uri.parse('$_baseUrl/ofertas'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las ofertas');
    }
  }

  Future<void> createOferta(Map<String, dynamic> ofertaData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/ofertas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ofertaData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la oferta');
    }
  }

  // 9. Terrenos (Lands)
  Future<void> createLand(Map<String, dynamic> landData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/terrenos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(landData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el terreno');
    }
  }

  Future<List<dynamic>> fetchLands(int idAgricultor) async {
    final response = await http.get(Uri.parse('$_baseUrl/terrenos?agricultor_id=$idAgricultor'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los terrenos');
    }
  }

  // Método de búsqueda de agricultores por ID
  Future<List<Map<String, dynamic>>> busquedaAgricultor() async {
    final response = await http.get(Uri.parse('$_baseUrl/agricultores'));
    if (response.statusCode == 200) {
      // Parseamos y retornamos la lista de agricultores
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los agricultores');
    }
  }
}

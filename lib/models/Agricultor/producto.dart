// lib/models/agricultor/producto.dart

class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final int idCategoria;

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.idCategoria,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      idCategoria: json['id_categoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'id_categoria': idCategoria,
    };
  }
}

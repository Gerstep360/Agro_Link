// lib/models/produccion.dart

class Produccion {
  final int? id;
  final int idTerreno;
  final int idTemporada;
  final int idProducto;
  final int cantidadDisponible;
  final String fechaRecoleccion;

  Produccion({
    this.id,
    required this.idTerreno,
    required this.idTemporada,
    required this.idProducto,
    required this.cantidadDisponible,
    required this.fechaRecoleccion,
  });

  factory Produccion.fromJson(Map<String, dynamic> json) {
    return Produccion(
      id: json['id'],
      idTerreno: json['id_terreno'],
      idTemporada: json['id_temporada'],
      idProducto: json['id_producto'],
      cantidadDisponible: json['cantidad_disponible'],
      fechaRecoleccion: json['fecha_recoleccion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_terreno': idTerreno,
      'id_temporada': idTemporada,
      'id_producto': idProducto,
      'cantidad_disponible': cantidadDisponible,
      'fecha_recoleccion': fechaRecoleccion,
    };
  }
}

// lib/models/terreno.dart

class Terreno {
  final int? id;
  final int idAgricultor;
  final double ubicacionLatitud;
  final double ubicacionLongitud;
  final String ubicacion;
  final double area;
  final double superficieTotal;
  final String descripcion;

  Terreno({
    this.id,
    required this.idAgricultor,
    required this.ubicacionLatitud,
    required this.ubicacionLongitud,
    required this.ubicacion,
    required this.area,
    required this.superficieTotal,
    required this.descripcion,
  });

  // Método para crear una instancia de Terreno a partir de JSON
  factory Terreno.fromJson(Map<String, dynamic> json) {
    return Terreno(
      id: json['id'],
      idAgricultor: json['id_agricultor'],
      ubicacionLatitud: (json['ubicacion_latitud'] as num).toDouble(),
      ubicacionLongitud: (json['ubicacion_longitud'] as num).toDouble(),
      ubicacion: json['ubicacion'],
      area: (json['area'] as num).toDouble(),
      superficieTotal: (json['superficie_total'] as num).toDouble(),
      descripcion: json['descripcion'],
    );
  }

  // Método para convertir Terreno a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_agricultor': idAgricultor,
      'ubicacion_latitud': ubicacionLatitud,
      'ubicacion_longitud': ubicacionLongitud,
      'ubicacion': ubicacion,
      'area': area,
      'superficie_total': superficieTotal,
      'descripcion': descripcion,
    };
  }
}

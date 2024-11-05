// lib/models/land.dart

class Land {
  int? id;  // ID del terreno, opcional para nuevas instancias
  int idAgricultor;
  double ubicacionLatitud;
  double ubicacionLongitud;
  String ubicacion;
  double area;
  double superficieTotal;
  String descripcion;

  Land({
    this.id,
    required this.idAgricultor,
    required this.ubicacionLatitud,
    required this.ubicacionLongitud,
    required this.ubicacion,
    required this.area,
    required this.superficieTotal,
    required this.descripcion,
  });

  // Método para crear una instancia de Land a partir de JSON
  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      id: json['id'],
      idAgricultor: json['id_agricultor'],
      ubicacionLatitud: (json['ubicacion_latitud'] as num).toDouble(),
      ubicacionLongitud: (json['ubicacion_longitud'] as num).toDouble(),
      ubicacion: (json['ubicacion']),
      area: (json['area'] as num).toDouble(),
      superficieTotal: (json['superficie_total'] as num).toDouble(),
      descripcion: json['descripcion'],
    );
  }

  // Método para convertir Land a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_agricultor': idAgricultor,
      'ubicacion_latitud': ubicacionLatitud,
      'ubicacion': ubicacion,
      'ubicacion_longitud': ubicacionLongitud,
      'area': area,
      'superficie_total': superficieTotal,
      'descripcion': descripcion,
    };
  }
}

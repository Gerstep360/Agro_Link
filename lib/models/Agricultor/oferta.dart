// lib/models/agricultor/oferta.dart

class Oferta {
  final int? id;
  final int idProduccion;
  final int idAgricultor;
  final double precioOferta;
  final int cantidadOferta;

  Oferta({
    this.id,
    required this.idProduccion,
    required this.idAgricultor,
    required this.precioOferta,
    required this.cantidadOferta,
  });

  factory Oferta.fromJson(Map<String, dynamic> json) {
    return Oferta(
      id: json['id'],
      idProduccion: json['id_produccion'],
      idAgricultor: json['id_agricultor'],
      precioOferta: (json['precio_oferta'] as num).toDouble(),
      cantidadOferta: json['cantidad_oferta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produccion': idProduccion,
      'id_agricultor': idAgricultor,
      'precio_oferta': precioOferta,
      'cantidad_oferta': cantidadOferta,
    };
  }
}

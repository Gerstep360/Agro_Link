// lib/models/cliente.dart

class Cliente {
  final int? id;
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;
  final String direccion;
  final String ubicacionLatitud;
  final String ubicacionLongitud;

  Cliente({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.ubicacionLatitud,
    required this.ubicacionLongitud,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      ubicacionLatitud: json['ubicacion_latitud'],
      ubicacionLongitud: json['ubicacion_longitud'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'ubicacion_latitud': ubicacionLatitud,
      'ubicacion_longitud': ubicacionLongitud,
    };
  }
}

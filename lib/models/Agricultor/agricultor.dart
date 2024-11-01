// lib/models/Agricultor/agricultor.dart

class Agricultor {
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;
  final String informacionBancaria;
  final String nit;
  final String carnet;
  final String licenciaFuncionamiento;
  final String estado;
  final String direccion;

  Agricultor({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.informacionBancaria,
    required this.nit,
    required this.carnet,
    required this.licenciaFuncionamiento,
    required this.estado,
    required this.direccion,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
      'informacion_bancaria': informacionBancaria,
      'nit': nit,
      'carnet': carnet,
      'licencia_funcionamiento': licenciaFuncionamiento,
      'estado': estado,
      'direccion': direccion,
    };
  }
}

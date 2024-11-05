// lib/models/user.dart

class User {
  final int id;
  final String nombre;
  final int edad;

  User({required this.id, required this.nombre, required this.edad});

  // Método para convertir JSON a un objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      edad: json['edad'],
    );
  }

  // Método para convertir el objeto User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
    };
  }
}

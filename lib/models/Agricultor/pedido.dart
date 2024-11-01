// lib/models/pedido.dart

class Pedido {
  final int? id;
  final int idCliente;
  final String estado;
  final String fechaEntrega;

  Pedido({
    this.id,
    required this.idCliente,
    required this.estado,
    required this.fechaEntrega,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      idCliente: json['id_cliente'],
      estado: json['estado'],
      fechaEntrega: json['fecha_entrega'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'estado': estado,
      'fecha_entrega': fechaEntrega,
    };
  }
}

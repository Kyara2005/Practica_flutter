import 'producto.dart';

class Pago {
  final Producto producto;
  final double total;
  final String titular;
  final String ultimos4;
  final String estado;
  final DateTime fecha;
  final double? latitud;
  final double? longitud;

  Pago({
    required this.producto,
    required this.total,
    required this.titular,
    required this.ultimos4,
    required this.estado,
    required this.fecha,
    this.latitud,
    this.longitud,
  });
}

import 'dart:math';

import '../models/producto.dart';

String simularPago() {
  final aprobado = Random().nextBool();
  return aprobado ? 'APROBADO' : 'RECHAZADO';
}

final productos = [
  Producto('Audífonos Bluetooth', 25),
  Producto('Teclado Mecánico', 45),
  Producto('Mouse Gamer', 30),
  Producto('Monitor 24"', 150),
  Producto('Laptop', 800),
  Producto('Tablet', 300),
  Producto('Smartphone', 500),
];

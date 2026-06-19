import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/pago.dart';
import '../models/producto.dart';

abstract class PagosRepository {
  Future<void> guardarPagoSupabase(Pago pago);
  Future<void> guardarPagoFirebase(Pago pago);
  Future<List<Pago>> obtenerHistorial();
}

class InMemoryPagosRepository implements PagosRepository {
  final List<Pago> _pagos = [];

  @override
  Future<void> guardarPagoSupabase(Pago pago) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _pagos.add(pago);
  }

  @override
  Future<void> guardarPagoFirebase(Pago pago) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _pagos.add(pago);
  }

  @override
  Future<List<Pago>> obtenerHistorial() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_pagos.reversed.toList());
  }
}

class SupabasePagosRepository implements PagosRepository {
  final supabase = Supabase.instance.client;
  final List<Pago> _pagosCacheados = [];

  @override
  Future<void> guardarPagoSupabase(Pago pago) async {
    try {
      await supabase.from('pagos_simulados').insert({
        'producto': pago.producto.nombre,
        'total': pago.total,
        'titular': pago.titular,
        'ultimos4': pago.ultimos4,
        'estado': pago.estado,
      });
      _pagosCacheados.add(pago);
    } catch (e) {
      print('Error guardando pago en Supabase: $e');
      rethrow;
    }
  }

  @override
  Future<void> guardarPagoFirebase(Pago pago) async {
    // Implementar si se usa Firebase en lugar de Supabase
    print('Firebase no implementado aún');
  }

  @override
  Future<List<Pago>> obtenerHistorial() async {
    try {
      final response = await supabase
          .from('pagos_simulados')
          .select()
          .order('fecha', ascending: false);

      final pagos = <Pago>[];
      for (final item in response) {
        pagos.add(
          Pago(
            producto: Producto(item['producto'] as String, 0),
            total: (item['total'] as num).toDouble(),
            titular: item['titular'] as String,
            ultimos4: item['ultimos4'] as String,
            estado: item['estado'] as String,
            fecha: DateTime.parse(item['fecha'].toString()),
          ),
        );
      }
      return pagos;
    } catch (e) {
      print('Error obteniendo historial de Supabase: $e');
      return [];
    }
  }
}

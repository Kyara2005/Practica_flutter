import 'package:flutter/material.dart';

import '../models/pago.dart';

class HistorialPage extends StatelessWidget {
  final List<Pago> pagos;

  const HistorialPage({super.key, required this.pagos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de pagos')),
      body: pagos.isEmpty
          ? const Center(child: Text('Aún no hay pagos guardados.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: pagos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final pago = pagos[index];
                return Card(
                  child: ListTile(
                    title: Text(pago.producto.nombre),
                    subtitle: Text('Total: \$${pago.total.toStringAsFixed(2)}\n${pago.fecha.toLocal()}'.split('.').first),
                    trailing: Text(pago.estado, style: TextStyle(color: pago.estado == 'APROBADO' ? Colors.green : Colors.red)),
                  ),
                );
              },
            ),
    );
  }
}

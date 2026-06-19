import 'package:flutter/material.dart';

import '../models/producto.dart';
import '../services/pagos_repository.dart';
import 'pago_page.dart';

class ResumenPage extends StatelessWidget {
  final Producto producto;
  final PagosRepository repository;

  const ResumenPage({super.key, required this.producto, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(producto.nombre, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Precio: \$${producto.precio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total a pagar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('\$${producto.precio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PagoPage(producto: producto, repository: repository),
                  ),
                );
              },
              child: const Text('Confirmar total'),
            ),
          ],
        ),
      ),
    );
  }
}

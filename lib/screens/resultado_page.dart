import 'package:flutter/material.dart';
import 'ExtrasPage.dart';

import '../models/pago.dart';

class ResultadoPage extends StatelessWidget {
  final String estado;
  final Pago pago;

  const ResultadoPage({super.key, required this.estado, required this.pago});

  @override
  Widget build(BuildContext context) {
    final aprobado = estado == 'APROBADO';

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              aprobado ? Icons.check_circle : Icons.error,
              size: 96,
              color: aprobado ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              estado,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text('Producto: ${pago.producto.nombre}', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Total: \$${pago.total.toStringAsFixed(2)}', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Últimos 4 dígitos: ${pago.ultimos4}', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Fecha: ${pago.fecha.toLocal()}'.split('.').first, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            //Agregar un boton para ir a extras page

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ExtrasPage()),
                );
              },
              child: const Text('Adjuntar comprobante'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

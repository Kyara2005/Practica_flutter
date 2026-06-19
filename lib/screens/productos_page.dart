import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../services/pagos_repository.dart';
import 'resumen_page.dart';

class ProductosPage extends StatelessWidget {
  final PagosRepository repository;

  const ProductosPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto.nombre),
            subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResumenPage(
                    producto: producto,
                    repository: repository,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.history),
        onPressed: () async {
          final historial = await repository.obtenerHistorial();
          Navigator.pushNamed(context, '/historial', arguments: historial);
        },
      ),
    );
  }
}

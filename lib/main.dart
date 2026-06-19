import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/pago.dart';
import 'screens/historial_page.dart';
import 'screens/productos_page.dart';
import 'services/pagos_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://haubjiclkskymrpuuqph.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhdWJqaWNsa3NreW1ycHV1cXBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg3NzgxMTcsImV4cCI6MjA5NDM1NDExN30.A8CqXytC6X3pjn7eSoqf6vGtpoTqSXPxb_9i5GtywUk',
  );

  runApp(const PagosApp());
}

class PagosApp extends StatelessWidget {
  const PagosApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = SupabasePagosRepository();

    return MaterialApp(
      title: 'Taller de pagos',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: ProductosPage(repository: repository),
      onGenerateRoute: (settings) {
        if (settings.name == '/historial') {
          final pagos = settings.arguments as List<Pago>? ?? [];
          return MaterialPageRoute(
            builder: (_) => HistorialPage(pagos: pagos),
          );
        }
        return null;
      },
    );
  }
}

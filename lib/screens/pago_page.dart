import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/producto.dart';
import '../models/pago.dart';
import '../services/pagos_repository.dart';
import 'resultado_page.dart';
import 'package:geolocator/geolocator.dart';


class PagoPage extends StatefulWidget {
  final Producto producto;
  final PagosRepository repository;

  const PagoPage({super.key, required this.producto, required this.repository});

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  final formKey = GlobalKey<FormState>();
  final titular = TextEditingController();
  final tarjeta = TextEditingController();
  final expiracion = TextEditingController();
  final cvv = TextEditingController();
  double? latitud;
  double? longitud;
  bool _guardando = false;

  String _obtenerUltimos4(String numeroTarjeta) {
    final cleaned = numeroTarjeta.replaceAll(' ', '');
    return cleaned.length >= 4 ? cleaned.substring(cleaned.length - 4) : cleaned;
  }

  Future<Position?> obtenerUbicacionActual() async {
    final servicioActivo = await Geolocator.isLocationServiceEnabled();

    if (!servicioActivo) {
      return null;
    }

    LocationPermission permiso = await Geolocator.checkPermission();

    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    if (permiso == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> cargarUbicacion() async {
    final posicion = await obtenerUbicacionActual();

    if (posicion == null) return;

    setState(() {
      latitud = posicion.latitude;
      longitud = posicion.longitude;
    });
  }


  Future<void> _procesarPago() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      _guardando = true;
    });

    final estado = simularPago();
    final pago = Pago(
      producto: widget.producto,
      total: widget.producto.precio,
      titular: titular.text.trim(),
      ultimos4: _obtenerUltimos4(tarjeta.text),
      estado: estado,
      fecha: DateTime.now(),
      latitud: latitud,
      longitud: longitud,
    );

    //await widget.repository.guardarPagoFirebase(pago);
    await widget.repository.guardarPagoSupabase(pago);

    if (!mounted) return;

    setState(() {
      _guardando = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultadoPage(estado: estado, pago: pago)),
    );
  }

  @override
  void dispose() {
    titular.dispose();
    tarjeta.dispose();
    expiracion.dispose();
    cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos de pago')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text('Producto: ${widget.producto.nombre}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Total: \$${widget.producto.precio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              TextFormField(
                controller: titular,
                decoration: const InputDecoration(labelText: 'Nombre del titular'),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tarjeta,
                decoration: const InputDecoration(labelText: 'Número de tarjeta'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final digits = value?.replaceAll(' ', '') ?? '';
                  if (digits.isEmpty) return 'Campo obligatorio';
                  if (digits.length < 16) return 'Debe tener al menos 16 dígitos';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: expiracion,
                decoration: const InputDecoration(labelText: 'Fecha de expiración'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: cvv,
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  final digits = value ?? '';
                  if (digits.isEmpty) return 'Campo obligatorio';
                  if (digits.length != 3) return 'Debe tener 3 dígitos';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _guardando ? null : cargarUbicacion,
                child: const Text('Obtener ubicación actual'),
              ),
              Text('Latitud: ${latitud ?? "Sin dato"}'),
              Text('Longitud: ${longitud ?? "Sin dato"}'),

              // Otra forma de agregar la latitud y longitud sin numeros
              // if (latitud != null && longitud != null)
              //   const Text(
              //     '✓ Ubicación obtenida',
              //     style: TextStyle(color: Colors.green),
              //   )
              // else
              //   const Text(
              //     'Ubicación no registrada (opcional)',
              //   ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _guardando ? null : _procesarPago,
                child: _guardando ? const CircularProgressIndicator(color: Colors.white) : const Text('Pagar ahora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ExtrasPage extends StatefulWidget {
  const ExtrasPage({super.key});

  @override
  State<ExtrasPage> createState() => _ExtrasPageState();
}

class _ExtrasPageState extends State<ExtrasPage> {
  final ImagePicker picker = ImagePicker();
  File? imagen;
  double? latitud;
  double? longitud;

  Future<void> tomarFoto() async {
    final XFile? foto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (foto == null) return;

    setState(() {
      imagen = File(foto.path);
    });
  }

  Future<void> obtenerUbicacion() async {
    final servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) return;

    LocationPermission permiso = await Geolocator.checkPermission();

    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    if (permiso == LocationPermission.deniedForever) return;

    final posicion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      latitud = posicion.latitude;
      longitud = posicion.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS + Cámara')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: tomarFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tomar foto'),
            ),
            const SizedBox(height: 16),
            imagen == null
                ? const Text('Sin imagen capturada')
                : Image.file(imagen!, height: 250, fit: BoxFit.cover),
            const Divider(height: 32),
            ElevatedButton.icon(
              onPressed: obtenerUbicacion,
              icon: const Icon(Icons.location_on),
              label: const Text('Obtener ubicación'),
            ),
            const SizedBox(height: 16),
            Text('Latitud: ${latitud ?? "Sin dato"}'),
            Text('Longitud: ${longitud ?? "Sin dato"}'),
          ],
        ),
      ),
    );
  }
}
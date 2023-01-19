import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/models.dart';

/// Clase dedicada a mostrar la vista de Google Maps
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  /// Para controlar la vista del google maps
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool normalWorld = true;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    /// Establecemos el punto de las coordenadas geograficas
    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLating(),
      zoom: 18,
      tilt: 25,
    );

    Set<Marker> markers = Set();

    /// Para que salga el marcador con el punto rojo
    markers.add(Marker(
      markerId: MarkerId('QRCode'),
      position: scan.getLating(),
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFdb4a39),
        title: const Text('Ubicacion'),
        actions: [
          IconButton(
            /// Para mover la camara a un punto indicado
            onPressed: () async {
              GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(_puntInicial));
            },
            icon: const Icon(Icons.location_history),
          )
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: normalWorld ? MapType.normal : MapType.satellite,
        markers: markers,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          normalWorld = !normalWorld;
        }),
        child: const Icon(
          Icons.clear_all,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}

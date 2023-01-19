import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/widgets.dart';

/// Clase para la pagina de GEO
/// Simplemente enseña el ScanTile dedicado a geo
class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo');
  }
}

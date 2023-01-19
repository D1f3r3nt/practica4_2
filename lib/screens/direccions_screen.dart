import 'package:flutter/material.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/widgets/widgets.dart';

/// Clase para la pagina de HTTP
/// Simplemente enseña el ScanTile dedicado a http
class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipus: 'http');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/models.dart';
import 'package:qr_scan/providers/providers.dart';
import 'package:qr_scan/utils/utils.dart';

/// Widget dedicado a escanear el contenido
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D88EF', 'Cancelar', false, ScanMode.QR);

        /// Solo para el video
        barcodeScanRes = 'https://paucasesnovescifp.cat';
        //barcodeScanRes = 'geo:39.7260847,2.9113035';

        /// En caso de que se cancele
        if (barcodeScanRes == '-1') return;

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.newScan(barcodeScanRes);

        launchURL(context, ScanModel(valor: barcodeScanRes));
      },
    );
  }
}

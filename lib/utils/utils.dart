import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipus == 'http') {
    if (!await launch(scan.valor)) throw 'Could not launch ${scan.valor}';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}

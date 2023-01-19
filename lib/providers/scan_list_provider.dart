import 'package:flutter/material.dart';
import 'package:qr_scan/models/models.dart';
import 'package:qr_scan/providers/providers.dart';

/// Clase dedicada a proveer la listas para cada situacion
/// Se trata de un Provider
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> newScan(String valor) async {
    final newScan = ScanModel(valor: valor);

    final id = await DBProvider.db.insertScan(newScan);

    newScan.id = id;

    if (newScan.tipus == tipusSeleccionat) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  carregarScans() async {
    final scans = await DBProvider.db.getAllScans();

    this.scans = [...scans];

    notifyListeners();
  }

  carregarScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);

    this.scans = [...scans];

    notifyListeners();
  }

  esborrarTots() async {
    final affected = await DBProvider.db.deleteAllScan();

    this.scans = [];

    notifyListeners();
  }

  esborrarPerId(int id) async {
    final affected = await DBProvider.db.deleteScanById(id);

    this.scans.removeWhere(
          (element) => element.id == id,
        );

    notifyListeners();
  }
}

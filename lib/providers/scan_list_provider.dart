import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

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

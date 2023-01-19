import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase dedicada a guardar los datos en la base de datos SQFLITE,
/// para asi tener persistencia

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDb();

    return _database!;
  }

  /// Para iniciar la base de datos
  Future<Database> initDb() async {
    // Obtenir es path
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'Scans.db');
    print(path);

    // Creació de la BBDD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipus TEXT,
          valor TEXT
        )
        ''');
      },
    );
  }

  // Manera tradicional
  Future<int> insertRawScan(ScanModel scan) async {
    final id = scan.id;
    final tipus = scan.tipus;
    final valor = scan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
      VALUES ($id, $tipus, $valor)
    ''');

    return res;
  }

  // Amb JSON
  Future<int> insertScan(ScanModel scan) async {
    final db = await database;

    final res = await db.insert('Scans', scan.toJson());

    return res;
  }

  // Collir tots els camps
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  // Collir camp per id
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromJson(res.first);
    }

    return null;
  }

  // Collir per tipus
  Future<List<ScanModel>> getScanByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  // Per actualitzar
  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = db.update(
      'Scans',
      scan.toJson(),
      where: 'id = ?',
      whereArgs: [scan.id],
    );

    return res;
  }

  // Per borrar tots
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }

  // Per borrar per ID
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }
}

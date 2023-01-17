import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database {
    if (_database != null) return _database;

    //_database = await initDb();

    return _database;
  }
}

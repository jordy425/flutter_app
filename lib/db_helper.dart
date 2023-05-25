import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._instance();

  DbHelper._instance();

  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final db = openDatabase(
      join(await getDatabasesPath(), 'productos_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE productos(id INTEGER PRIMARY KEY, nombre TEXT, cantidad INTEGER, precio DOUBLE)",
        );
      },
      version: 1,
    );
    return db;
  }
}

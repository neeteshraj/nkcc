import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'table_creation.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'local_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await TableCreation.createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await TableCreation.migrate(db, oldVersion, newVersion);
      },
    );
  }
}

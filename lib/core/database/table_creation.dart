import 'package:sqflite/sqflite.dart';

class TableCreation {
  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        username TEXT,
        fullName TEXT,
        role TEXT,
        phoneNumber TEXT,
        password TEXT,
        billNumbers TEXT, 
        fcmToken TEXT,
        profilePicture TEXT 
      );
    ''');
  }

  static Future<void> migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE users ADD COLUMN profilePicture TEXT;
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        ALTER TABLE users ADD COLUMN role TEXT;
      ''');
    }
    if (oldVersion < 4) {
      await db.execute('''
        ALTER TABLE users ADD COLUMN billNumbers TEXT;
      ''');
    }
    if (oldVersion < 5) {
      await db.execute('''
        ALTER TABLE users ADD COLUMN fcmToken TEXT;
      ''');
    }
  }
}

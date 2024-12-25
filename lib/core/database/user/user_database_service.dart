import 'package:sqflite/sqflite.dart';
import 'package:support/core/database/database_helper.dart';

class UserDatabaseService {
  final DatabaseHelper _databaseHelper;

  UserDatabaseService({required DatabaseHelper databaseHelper}) : _databaseHelper = databaseHelper;

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await _databaseHelper.database;
    await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await _databaseHelper.database;
    return await db.query('users');
  }

  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await _databaseHelper.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> updateUser(int id, Map<String, dynamic> user) async {
    final db = await _databaseHelper.database;
    await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}

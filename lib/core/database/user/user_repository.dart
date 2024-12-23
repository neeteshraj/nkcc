import 'package:support/core/database/user/user_database_service.dart';

class UserRepository {
  final UserDatabaseService userDatabaseService;

  UserRepository({required this.userDatabaseService});

  Future<void> addUser(Map<String, dynamic> user) async {
    await userDatabaseService.insertUser(user);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await userDatabaseService.getUsers();
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    return await userDatabaseService.getUser(id);
  }

  Future<void> updateUser(int id, Map<String, dynamic> user) async {
    await userDatabaseService.updateUser(id, user);
  }

  Future<void> deleteUser(int id) async {
    await userDatabaseService.deleteUser(id);
  }
}

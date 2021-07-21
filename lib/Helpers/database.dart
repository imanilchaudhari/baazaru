import 'dart:io';

import 'package:baazaru/Models/user.dart';

class DatabaseHelper {
  Future<int> insertUser(User user) async {
    return 1;
  }

  Future<int> updateUser(User user) async {
    return 1;
  }

  Future<int> deleteUser(int id) async {
    return 0;
  }

  Future<List<User>> fetchUser() async {
    return [];
  }
}

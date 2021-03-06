import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baazaru/conf.dart';
import 'package:baazaru/Models/user.dart';

class UserService {
  static var path = "api/v1/users";

  static Future<List<User>> getAll() async {
    final response = await http.get(Uri.https(Config.url, UserService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      // print(data);
      return List<User>.from(data.map((e) => User.fromMap(e)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

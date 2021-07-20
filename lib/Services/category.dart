import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baazaru/conf.dart';
import 'package:baazaru/Models/category.dart';

class CategoryService {
  static var path = "api/v1/categories";

  static Future<List<Category>> getAll() async {
    final response =
        await http.get(Uri.https(Config.url, CategoryService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      // print(data);
      return List<Category>.from(data.map((e) => Category.fromJson(e)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baazaru/Utils/config.dart';
import 'package:baazaru/Models/product.dart';

class ProductService {
  static var path = "api/v1/products";

  static Future<List<Product>> getAll() async {
    final response = await http.get(Uri.https(Config.url, ProductService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      // print(data);
      return List<Product>.from(data.map((e) => Product.fromJson(e)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return List<Product>();
      // throw Exception('Failed to load album');
    }
  }
}

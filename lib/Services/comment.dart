import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:baazaru/conf.dart';
import 'package:baazaru/Models/comment.dart';

class CommentService {
  static var path = "api/v1/comments";

  static Future<List<Comment>> getAll() async {
    final response = await http.get(Uri.https(Config.url, CommentService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      // print(data);
      return List<Comment>.from(data.map((e) => Comment.fromJson(e)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

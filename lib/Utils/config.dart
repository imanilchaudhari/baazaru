import 'dart:io';

class Config {
  static const url = "baazaru.com";

  static headers() {
    var token = 'some-awesome-bearer-token';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer" + token,
    };
    return header;
  }
}

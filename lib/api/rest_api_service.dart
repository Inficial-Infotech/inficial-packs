import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class RestApiService {
  static String baseUrl = 'http://13.239.140.173:8008/api/v1/';

  Future<http.Response> get(String path) {
    return http.get(
      Uri.parse('$baseUrl$path'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> post(String path, Object? body) {
    return http.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}

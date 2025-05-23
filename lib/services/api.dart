import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://your-backend-url.com/api';

  // Example GET request
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url);
  }

  // Example POST request
  static Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.post(url, headers: headers, body: body);
  }
} 
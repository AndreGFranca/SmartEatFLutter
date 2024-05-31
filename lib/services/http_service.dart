import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_eats/services/storage_service.dart';

class HttpService {
  String _apiUrl = dotenv.env['API_URL']!;
  SecureStorage storage = SecureStorage();
  late String authorization = '';

  Future<String?> HasAuthorization()async{
    print(await storage.readToken());
    authorization = await storage.readToken() ?? '';
    return await storage.readToken() ?? '';
  }


  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_apiUrl$endpoint'), headers: {
      'Content-Type': 'application/json',
      if (await HasAuthorization() != null) 'Authorization': 'Bearer $authorization',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    print(authorization);
    final response = await http.put(
      Uri.parse('$_apiUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (await HasAuthorization() != null) 'Authorization': 'Bearer $authorization',
      },
      body: jsonEncode(data),
    );
    print('$_apiUrl$endpoint');
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        try {
          return response.body;
        } catch (ex) {
          print(ex.toString());
        }
      }
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$_apiUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (await HasAuthorization() != null) 'Authorization': 'Bearer ${authorization}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        try {
          return response.body;
        } catch (ex) {
          print(ex.toString());
        }
      }
    } else {
      throw Exception('Failed to post data');
    }
  }
}

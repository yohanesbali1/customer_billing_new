import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ApiProvider {
  final storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<Map<String, String>> _headers() async {
    final token = await storage.read(key: 'token');
    return {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);
    final response = await http.get(uri, headers: await _headers());
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? files,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _headers();

    if (files == null || files.isEmpty) {
      final response = await http.post(
        uri,
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } else {
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      for (var entry in files.entries) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, entry.value),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      return _handleResponse(response);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? files, // fieldName:filePath
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _headers();

    if (files == null || files.isEmpty) {
      final response = await http.put(
        uri,
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } else {
      final request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(headers);

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Files
      for (var entry in files.entries) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, entry.value),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      return _handleResponse(response);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (data.containsKey('meta')) {
        return {'meta': data['meta'], 'data': data['data']};
      }
      return data;
    }

    if (response.statusCode == 401) {
      storage.delete(key: 'token');
      Get.offAllNamed('/login');
      throw Exception('Sesi login berakhir, silakan login ulang.');
    }

    throw Exception(data['message'] ?? 'Terjadi kesalahan, silakan coba lagi.');
  }
}

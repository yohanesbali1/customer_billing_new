import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    bool customUrl = false,
  }) async {
    final uri = Uri.parse(
      customUrl ? endpoint : '$baseUrl$endpoint',
    ).replace(queryParameters: query);
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

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final Map<String, dynamic> data = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        if (data.containsKey('meta')) {
          return {'meta': data['meta'], 'data': data['data']};
        }
        return data;

      case 401:
        await _handleUnauthorized();
        throw Exception('Sesi login berakhir, silakan login ulang.');

      default:
        final message =
            data['message'] ?? 'Terjadi kesalahan, silakan coba lagi.';
        throw Exception(message);
    }
  }

  Future<void> _handleUnauthorized() async {
    try {
      await storage.delete(key: 'token');
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      rethrow;
    } finally {
      if (Get.currentRoute != '/login') {
        Get.offAllNamed('/login');
      }
    }
  }
}

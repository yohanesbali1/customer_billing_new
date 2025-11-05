part of 'providers.dart';

class HelperProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<ReportResponseModel> getData({page = 1, perPage = 10}) async {
    final String? token = await storage.read(key: 'token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customer/complaint?page=$page&perPage=$perPage'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return ReportResponseModel.fromJson(responseData);
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        throw 'Sesi login berakhir, silakan login ulang.';
      }
      throw data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<ReportModelDetail?> showreportData(dynamic id) async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/customer/complaint/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] == null) {
          return null;
        }
        return ReportModelDetail.fromJson(responseData['data']);
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  deletereportData(dynamic id) async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.delete(
        Uri.parse('$baseUrl/customer/complaint/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  dynamic submitReportData(dynamic data) async {
    try {
      final String? token = await storage.read(key: 'token');
      var uri = Uri.parse(
        data['id'] == ''
            ? '$baseUrl/customer/complaint'
            : '$baseUrl/customer/complaint/${data['id']}',
      );

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add text fields
      data['form'].forEach((key, value) async {
        if (value is File) {
          request.files.add(
            await http.MultipartFile.fromPath(
              key,
              value.path,
              contentType: MediaType('image', 'jpeg'), // adjust as needed
            ),
          );
        } else {
          request.fields[key] = value.toString();
        }
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TypeTopic>> get_type() async {
    final String? token = await storage.read(key: 'token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customer/type-complaint'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return (data as List).map((e) => TypeTopic.fromJson(e)).toList();
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return [];
      }
      throw data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatResponse>> get_chat(payload, page) async {
    final String? token = await storage.read(key: 'token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customer/complaint/$payload/chat?page=${page}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return (data['data'] as List)
            .map((e) => ChatResponse.fromJson(e))
            .toList();
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return [];
      }
      throw data['message'];
    } catch (e) {
      rethrow;
    }
  }

  dynamic submitChat(dynamic data, payload) async {
    try {
      final String? token = await storage.read(key: 'token');

      var uri = Uri.parse('$baseUrl/customer/complaint/$payload/chat');

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add text fields
      data.forEach((key, value) async {
        if (value is File) {
          request.files.add(
            await http.MultipartFile.fromPath(
              key,
              value.path,
              contentType: MediaType('image', 'jpeg'), // adjust as needed
            ),
          );
        } else {
          request.fields[key] = value.toString();
        }
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  // dynamic submitFireStoreChat(dynamic form, payload) async {
  //   try {
  //     final response = FirebaseFirestore.instance
  //         .collection('chats')
  //         .doc("${payload}")
  //         .collection('messages')
  //         .add(form);
  //     return true;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  dynamic deleteChat(payload) async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.delete(
        Uri.parse('$baseUrl/customer/complaint/chat/${payload['chat_id']}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  // dynamic deleteFireStoreChat(payload) async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('chats')
  //         .doc("${payload}")
  //         .collection('messages')
  //         .doc("${payload}")
  //         .delete();
  //     return true;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}

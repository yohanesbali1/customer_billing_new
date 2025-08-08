part of 'providers.dart';

class InvoiceProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<List<InvoiceModel>> getData(String status) async {
    try {
      final String? token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('$baseUrl/customer/invoice?status=$status'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return (responseData['data'] as List)
            .map((e) => InvoiceModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return [];
      }
      throw responseData['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<InvoiceModel?> showinvoiceData(dynamic id) async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/customer/invoice/$id'),
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
        return InvoiceModel.fromJson(responseData['data']);
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
}

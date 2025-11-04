part of 'providers.dart';

class InvoiceProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<InvoiceResponseModel> getData({
    required String status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final String? token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse(
          '$baseUrl/customer/invoice?status=$status&per_page=$perPage&page=$page',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return InvoiceResponseModel.fromJson(responseData);
      }

      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.offAllNamed('/login');
        throw 'Sesi login berakhir, silakan login ulang.';
      }

      throw json.decode(response.body)['message'] ?? 'Gagal memuat data';
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

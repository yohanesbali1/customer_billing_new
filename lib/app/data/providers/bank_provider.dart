part of 'providers.dart';

class BankProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<List<BankGroupModel>> getData() async {
    final String? token = await storage.read(key: 'token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customer/bank?type=vigo'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return (data as List).map((e) => BankGroupModel.fromJson(e)).toList();
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

  Future<BankModel?> showData(id) async {
    final String? token = await storage.read(key: 'token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customer/bank/${id}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (responseData['data'] == null) {
          return null;
        }
        return BankModel.fromJson(responseData['data']);
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        throw responseData['message'];
      }
      throw data['message'];
    } catch (e) {
      rethrow;
    }
  }
}

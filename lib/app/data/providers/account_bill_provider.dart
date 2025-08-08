part of 'providers.dart';

class AccountBillProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  Future<AccountBillModel?> getData() async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/customer/account-bill'),
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
        return AccountBillModel.fromJson(responseData['data']);
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

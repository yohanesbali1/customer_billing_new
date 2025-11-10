import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class HelpRepository {
  final ApiProvider api;

  HelpRepository({required this.api});

  Future<HelpResponseModel> getHelpData({
    required String status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await api.get(
        '/customer/complaint?page=$page&per_page=$perPage',
      );
      return HelpResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<HelpModelDetail?> showinvoiceData(dynamic id) async {
    try {
      final response = await api.get('/customer/complaint/$id');
      return HelpModelDetail.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitHelp(form) async {
    try {
      final response = await api.post(
        '/customer/complaint${form['id'] == '' ? '' : '/${form['id']}'}',
        form,
        files: form.image,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteHelp(dynamic id) async {
    try {
      final response = await api.delete('/customer/complaint/$id');
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

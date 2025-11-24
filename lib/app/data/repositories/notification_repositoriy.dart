import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class NotificationRepositoriy {
  final ApiProvider api;

  NotificationRepositoriy({required this.api});
  Future<NotificationResponseModel> getData({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await api.get(
        '/notification?page=$page&per_page=$perPage',
      );
      return NotificationResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> readAll() async {
    try {
      await api.post('/notification/read', {});
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class NotificationRepositoriy {
  final ApiProvider api;

  NotificationRepositoriy({required this.api});
  Future<AccountBillModel?> getProfile() async {
    try {
      final response = await api.get('/customer/account-bill');
      return AccountBillModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateDataTokenFCM() async {
    try {
      final token_fcm = await firebaseMessage.getToken();
      final form = {'id': token_fcm};
      await api.post('/auth/save-token', form);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

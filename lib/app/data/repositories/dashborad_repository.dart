import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class DashboardRepository {
  final ApiProvider api;

  DashboardRepository({required this.api});

  Future<DashboardModel> getData() async {
    try {
      final response = await api.get('/customer/dashboard');
      return DashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

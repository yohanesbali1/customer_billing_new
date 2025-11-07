import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class AccountBillRepository {
  final ApiProvider api;

  AccountBillRepository({required this.api});

  Future<AccountBillModel?> getAccountBill() async {
    final response = await api.get('/customer/account-bill');
    if (response['data'] == null) return null;
    return AccountBillModel.fromJson(response['data']);
  }
}

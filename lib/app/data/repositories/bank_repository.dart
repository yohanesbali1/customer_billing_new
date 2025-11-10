import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class BankRepository {
  final ApiProvider api;

  BankRepository({required this.api});

  Future<List<BankModel>> getBankData() async {
    try {
      final response = await api.get('/customer/bank');
      return (response['data'] as List)
          .map((e) => BankModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BankModel?> showDataBank(dynamic id) async {
    try {
      final response = await api.get('/customer/bank/$id');
      return BankModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class InvoiceRepository {
  final ApiProvider api;

  InvoiceRepository({required this.api});

  Future<InvoiceResponseModel> getInvoice({
    required String status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await api.get(
        '/customer/invoice?status=$status&per_page=$perPage&page=$page',
      );
      return InvoiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<InvoiceModel?> showinvoiceData(dynamic id) async {
    try {
      final response = await api.get('/customer/invoice/$id');
      return InvoiceModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }
}

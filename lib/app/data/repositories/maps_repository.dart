import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class MapsRepository {
  final ApiProvider api;
  const MapsRepository({required this.api});

  Future<List<MapModel>> getMap(String filter) async {
    try {
      final response = await api.get('/customer/maps?search=$filter');
      return (response['data'] as List)
          .map((e) => MapModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

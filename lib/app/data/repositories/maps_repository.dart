import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class MapsRepository {
  final ApiProvider api;
  const MapsRepository({required this.api});

  Future<List<MapModel>> getMap(String filter) async {
    try {
      final response = await api.get(
        'https://us1.locationiq.com/v1/search.php?key=pk.352d883cedfc088c2ad81167d4b4b673&q=$filter&format=json',
      );
      return (response as List).map((e) => MapModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

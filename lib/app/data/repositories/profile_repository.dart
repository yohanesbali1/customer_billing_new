import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ProfileRepository {
  final ApiProvider api;

  ProfileRepository({required this.api});
  Future<ProfileModel?> getProfile() async {
    try {
      final response = await api.get('/customer/auth/profile');
      return ProfileModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }
}

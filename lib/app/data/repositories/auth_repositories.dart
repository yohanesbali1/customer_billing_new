import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/services/local_storage_service.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiProvider api;
  final ApplicationControllers applicationControllers =
      Get.find<ApplicationControllers>();
  final LocalStorageService storage = LocalStorageService();

  AuthRepository({required this.api});

  Future<dynamic> loginData(form) async {
    try {
      final response = await api.post('/auth/login', form);
      await storage.write('token', response['token']);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> changePassword(form) async {
    try {
      final response = await api.post('/customer/auth/change-password', form);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic?> logoutData() async {
    try {
      await api.get('/auth/logout');
      await storage.clear();
      await FirebaseMessaging.instance.deleteToken();
      applicationControllers.clearProfile();
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

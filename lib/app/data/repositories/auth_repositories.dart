import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vigo_customer_billing/app/core/controllers/profile_controller.dart';
import 'package:vigo_customer_billing/app/core/services/local_storage_service.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiProvider api;
  final ProfileController profileController = Get.find<ProfileController>();
  final LocalStorageService storage = LocalStorageService();
  final FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;

  AuthRepository({required this.api});

  Future<dynamic> loginData(form) async {
    try {
      final response = await api.post('/auth/login', form);
      await storage.write('token', response['data']['token']);
      return LoginModel.fromJson(response['data']);
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
      final response = await api.get('/auth/logout');
      await storage.clear();
      profileController.clearProfile();
      return null;
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

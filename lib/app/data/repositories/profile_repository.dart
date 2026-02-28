import 'dart:io';

import 'package:vigo_billing/app/data/models/models.dart';
import 'package:vigo_billing/app/data/providers/api_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ProfileRepository {
  final ApiProvider api;
  // Avoid accessing FirebaseMessaging.instance at class init to prevent crash
  // final FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;

  ProfileRepository({required this.api});
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
      if (!Platform.isAndroid) return false;
      try {
        final token_fcm = await FirebaseMessaging.instance.getToken();
        final form = {'id': token_fcm};
        await api.post('/auth/save-token', form);
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}

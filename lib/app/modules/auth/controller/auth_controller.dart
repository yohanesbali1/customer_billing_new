import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';

class AuthController extends GetxController {
  Rxn<ProfileModel> profile = Rxn<ProfileModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      profile.value = await AuthProvider().getData();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Helper().AlertSnackBar();
    }
  }

  logoutData() async {
    try {
      Helper().AlertGetX('loading', null);
      await FirebaseMessaging.instance.deleteToken();
      await AuthProvider().logoutData();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.back();
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<dynamic> deleteAccountData() async {
    try {
      await AuthProvider().deleteData();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

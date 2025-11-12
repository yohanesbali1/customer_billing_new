import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/repositories/auth_repositories.dart';

class LoginController extends GetxController {
  final AuthRepository repository;
  LoginController({required this.repository});
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  OverlayEntry? overlayEntry = null;
  var password_status = true.obs;

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

  String? validator_input(value) {
    return value!.isEmpty ? 'Field ini harus diisi' : null;
  }

  Future<void> submit_login() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var data = {
        'username': usernameController.text,
        'password': passwordController.text,
        'group_app': 'VIGO',
      };
      await repository.loginData(data);
      await FirebaseMessaging.instance.deleteToken();
      isLoading(false);
      Get.back();
      Get.offAllNamed('/home');
    } catch (e) {
      Get.back();
      isLoading(false);
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }
}

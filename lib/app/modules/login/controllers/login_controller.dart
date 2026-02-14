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
  final Rxn<String> usernameError = Rxn<String>();
  final passwordController = TextEditingController();
  final Rxn<String> passwordError = Rxn<String>();

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

  bool validateUsername() {
    final val = usernameController.text.trim();
    if (val.isEmpty) {
      usernameError.value = 'Password harus diisi';
      return false;
    }
    usernameError.value = null;
    return true;
  }

  bool validatePassword() {
    final val = passwordController.text.trim();
    if (val.isEmpty) {
      passwordError.value = 'Password harus diisi';
      return false;
    }
    passwordError.value = null;
    return true;
  }

  Future<void> submit_login() async {
    try {
      isLoading(true);
      Helper().AlertGetX(type: 'loading');
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
      Helper().AlertGetX(message: errorMessage);
    }
  }
}

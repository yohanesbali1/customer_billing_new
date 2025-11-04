import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  //TODO: Implement HomeController.
  final formkey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var username = TextEditingController().obs;
  var password = TextEditingController().obs;
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

  submit_login() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var data = {
        'username': username.value.text,
        'password': password.value.text,
        'group_app': 'VIGO',
      };
      await FirebaseMessaging.instance.deleteToken();
      final LoginModel response = await AuthProvider().loginData(data);
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'token', value: response.token);
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

import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  //TODO: Implement HomeController.
  var password = TextEditingController().obs;
  var c_password = TextEditingController().obs;
  var new_password = TextEditingController().obs;
  final formkey = GlobalKey<FormState>();
  OverlayEntry? overlayEntry = null;
  var isLoading = false.obs;
  var c_password_status = true.obs;
  var password_status = true.obs;
  var new_password_status = true.obs;

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

  void clear_form() {
    password.value.clear();
    c_password.value.clear();
    new_password.value.clear();
  }

  String? validator_password(value) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    if (value.isEmpty) {
      return 'Field ini harus diisi';
    } else if (!regex.hasMatch(value)) {
      return 'Password min 8 karakter, 1 huruf besar dan 1 angka';
    }
    return null;
  }

  String? validator_c_password(value) {
    if (value.isEmpty) {
      return 'Field ini harus diisi';
    } else if (value != new_password.value.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  String? validator_input(value) {
    return value!.isEmpty ? 'Field ini harus diisi' : null;
  }

  update_password() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var data = {
        'password': password.value.text,
        'c_password': c_password.value.text,
        'new_password': new_password.value.text
      };
      await AuthProvider().updateData(data);
      clear_form();
      Get.back();
      await Helper().AlertGetX('success', "Password berhasil diubah");
      Get.back();
      isLoading(false);
    } catch (e) {
      Get.back();
      isLoading(false);
      String errorMessage =
          e is String ? e : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }
}

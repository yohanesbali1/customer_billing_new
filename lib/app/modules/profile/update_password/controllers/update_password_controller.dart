import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/repositories/auth_repositories.dart';

class UpdatePasswordController extends GetxController {
  final AuthRepository repository;
  UpdatePasswordController({required this.repository});
  final formkey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();

  // OverlayEntry? overlayEntry = null;
  var isLoading = false.obs;
  var c_password_status = true.obs;
  var password_status = true.obs;
  var new_password_status = true.obs;

  @override
  void onInit() {
    super.onInit();
    clear_form();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    clear_form();
  }

  void clear_form() {
    passwordController.clear();
    cpasswordController.clear();
    newpasswordController.clear();
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
    } else if (value != newpasswordController.text) {
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
        'password': passwordController.text,
        'c_password': cpasswordController.text,
        'new_password': newpasswordController.text,
      };
      await repository.changePassword(data);
      clear_form();
      Get.back();
      await Helper().AlertGetX('success', "Password berhasil diubah");
      Get.back();
      isLoading(false);
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

import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';
import 'package:vigo_customer_billing/app/data/services/notification_service.dart';
import 'package:vigo_customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController.
  var page_index = 0.obs;
  var pagecontroller = PageController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    this.pagecontroller.dispose();
  }

  @override
  void dispose() {
    pagecontroller.dispose(); // Dispose the controller here
    super.dispose();
  }

  void change_page(dynamic payload) {
    this.page_index.value = payload;
    this.pagecontroller.jumpToPage(payload);
  }

  void getData() async {
    try {
      await AuthProvider().updateDataTokenFCM();
    } catch (e) {
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController.
  var page_index = 0.obs;
  var pagecontroller = PageController();
  final ApplicationControllers applicationControllers = Get.find();

  @override
  void onInit() {
    super.onInit();
    applicationControllers.getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pagecontroller.dispose();
  }

  @override
  void dispose() {
    pagecontroller.dispose(); // Dispose the controller here
    super.dispose();
  }

  void change_page(dynamic payload) {
    page_index.value = payload;
    pagecontroller.jumpToPage(payload);
  }
}

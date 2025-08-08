import 'dart:async';

import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  var isLoading = false.obs;
  var report_data = <ReportModel>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    // Start a periodic function
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    // Cancel the subscription
    super.dispose();
  }

  @override
  Future<void> getData() async {
    try {
      isLoading.value = true;
      report_data.value = await HelperProvider().getData();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage =
          e is String ? e : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  change_status(status) {
    final payload;
    switch (status) {
      case '8':
        payload = {'color': redColor, 'icon': Icons.error};
        return payload;
      case '7':
        payload = {'color': greenColor, 'icon': Icons.done};
        return payload;
      default:
        payload = {'color': mainColor, 'icon': Icons.help};
        return payload;
    }
  }
}

import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryController extends GetxController {
  //TODO: Implement HomeController.
  var invoice_data = <InvoiceModel>[].obs;
  var pagecontroller = PageController();
  var page_index = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    change_page(0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    page_index.value = 0;
    this.pagecontroller.dispose();
  }

  void change_page(dynamic payload) {
    this.page_index.value = payload;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.pagecontroller.jumpToPage(payload);
    });
  }

  void getData(String status) async {
    try {
      isLoading(true);
      invoice_data.value = await InvoiceProvider().getData(status);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Helper().AlertSnackBar(null);
    }
  }

  String change_status(status) {
    switch (status) {
      case 'not_paid':
        return 'Belum Dibayar';
      case 'paid':
        return 'Sudah Dibayar';
      default:
        return '-';
    }
  }

  String status_message(status, dynamic paid_at) {
    switch (status) {
      case 'not_paid':
        return 'Belum Dibayar';
      case 'paid':
        return 'Sudah dibayar pada ${paid_at}';
      default:
        return '-';
    }
  }
}

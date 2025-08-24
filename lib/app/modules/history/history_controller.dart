import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var invoice_not_paid_data = <InvoiceModel>[].obs;
  var invoice_paid_data = <InvoiceModel>[].obs;
  var pagecontroller = PageController();
  var page_index = 0.obs;
  var isLoading = true.obs;

  bool _billLoaded = false;
  bool _paidLoaded = false;

  @override
  void onInit() {
    super.onInit();
    page_index.value = 0;
    loadPageData(0); // pertama kali masuk tab Tagihan
  }

  @override
  void onClose() {
    page_index.value = 0;
    loadPageData(0);
    pagecontroller.dispose();
    super.onClose();
  }

  void change_page(int index) {
    page_index.value = index;
    pagecontroller.jumpToPage(index);
    loadPageData(index);
  }

  void loadPageData(int index) {
    if (index == 0 && !_billLoaded) {
      getData('not_paid');
      _billLoaded = true;
    } else if (index == 1 && !_paidLoaded) {
      getData('paid');
      _paidLoaded = true;
    }
  }

  getData(String status) async {
    try {
      isLoading(true);
      final data = await InvoiceProvider().getData(status);
      if (status == 'not_paid') {
        invoice_not_paid_data.value = data;
      } else {
        invoice_paid_data.value = data;
      }
    } catch (e) {
      Helper().AlertSnackBar(null);
    } finally {
      isLoading(false);
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
        return 'Sudah dibayar pada $paid_at';
      default:
        return '-';
    }
  }
}

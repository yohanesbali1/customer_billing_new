import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var invoice_not_paid_data = <InvoiceModel>[].obs;
  var invoice_paid_data = <InvoiceModel>[].obs;

  var pagecontroller = PageController();
  var page_index = 0.obs;

  var isLoading = true.obs;
  var isLoadMore = false.obs;

  // Pagination tracking
  var currentPagePaid = 1.obs;
  var lastPagePaid = 1.obs;
  var currentPageNotPaid = 1.obs;
  var lastPageNotPaid = 1.obs;

  bool _billLoaded = false;
  bool _paidLoaded = false;

  @override
  void onInit() {
    super.onInit();
    page_index.value = 0;
    loadPageData(0);
  }

  @override
  void onClose() {
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

  Future<void> getData(String status, {bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (status == 'paid' && currentPagePaid.value >= lastPagePaid.value)
          return;
        if (status == 'not_paid' &&
            currentPageNotPaid.value >= lastPageNotPaid.value)
          return;

        isLoadMore(true);
      } else {
        isLoading(true);
      }

      // Tentukan halaman
      int currentPage = 1;
      if (status == 'paid') {
        currentPage = loadMore ? currentPagePaid.value + 1 : 1;
      } else {
        currentPage = loadMore ? currentPageNotPaid.value + 1 : 1;
      }

      final response = await InvoiceProvider().getData(
        status: status,
        page: currentPage,
        perPage: 10,
      );

      if (status == 'paid') {
        if (loadMore) {
          invoice_paid_data.addAll(response.data);
          currentPagePaid.value = currentPage;
        } else {
          invoice_paid_data.assignAll(response.data);
          currentPagePaid.value = 1;
        }
        lastPagePaid.value = response.meta?.lastPage ?? 1;
      } else {
        if (loadMore) {
          invoice_not_paid_data.addAll(response.data);
          currentPageNotPaid.value = currentPage;
        } else {
          invoice_not_paid_data.assignAll(response.data);
          currentPageNotPaid.value = 1;
        }
        lastPageNotPaid.value = response.meta?.lastPage ?? 1;
      }
    } catch (e) {
      Helper().AlertSnackBar();
    } finally {
      isLoading(false);
      isLoadMore(false);
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

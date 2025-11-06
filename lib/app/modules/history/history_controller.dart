import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var invoice_not_paid_data = <InvoiceModel>[].obs;
  var invoice_paid_data = <InvoiceModel>[].obs;
  var type = 'not_paid'.obs;
  var perPage = 10.obs;

  var pagecontroller = PageController();
  var page_index = 0.obs;

  var isLoading = true.obs;
  var isLoadMore = false.obs;

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
    final context = Get.context!;
    perPage.value = Helper().calculatePerPage(context);
    loadPageData(0);
    scrollController.addListener(onScroll);
  }

  @override
  void onClose() {
    super.onClose();
    pagecontroller.dispose();
    scrollController.dispose();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadMore.value) {
      final isPaid = type.value == 'paid';
      if ((isPaid && currentPagePaid.value < lastPagePaid.value) ||
          (!isPaid && currentPageNotPaid.value < lastPageNotPaid.value)) {
        getData(type.value, loadMore: true);
      }
    }
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
      final isPaid = status == 'paid';

      final currentPage = isPaid ? currentPagePaid : currentPageNotPaid;
      final lastPage = isPaid ? lastPagePaid : lastPageNotPaid;
      final invoiceData = isPaid ? invoice_paid_data : invoice_not_paid_data;

      if (loadMore && currentPage.value >= lastPage.value) return;

      loadMore ? isLoadMore(true) : isLoading(true);

      final nextPage = loadMore ? currentPage.value + 1 : 1;

      final response = await InvoiceProvider().getData(
        status: status,
        page: nextPage,
        perPage: perPage.value,
      );

      if (loadMore) {
        invoiceData.addAll(response.data);
      } else {
        invoiceData.assignAll(response.data);
      }

      currentPage.value = nextPage;
      (isPaid ? lastPagePaid : lastPageNotPaid).value =
          response.meta?.lastPage ?? 1;
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

import 'dart:async';

import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/help_repository.dart';

class HelpController extends GetxController {
  final HelpRepository repository;
  HelpController({required this.repository});
  var isLoading = false.obs;
  var report_data = <HelpModel>[].obs;
  var page_index = 0.obs;
  var isLoadMore = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var perPage = 10.obs;
  final scrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();
    final context = Get.context!;
    perPage.value = Helper().calculatePerPage(context);
    getData();
    scrollController.addListener(() => onScroll());
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
    scrollController.dispose();
  }

  dynamic onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadMore.value) {
      if (currentPage.value < lastPage.value) {
        getData(loadMore: true);
      }
    }
  }

  Future<void> getData({bool loadMore = false}) async {
    try {
      if (loadMore && currentPage.value >= lastPage.value) return;
      // isLoadMore(true);
      if (loadMore) {
        isLoadMore.value = true;
      } else {
        isLoading.value = true;
      }

      int _currentPage;
      _currentPage = loadMore ? currentPage.value + 1 : 1;
      final response = await repository.getHelpData(
        page: _currentPage,
        perPage: perPage.value,
      );
      if (loadMore) {
        report_data.addAll(response.data);
      } else {
        report_data.assignAll(response.data);
      }
      currentPage.value = loadMore ? _currentPage : 1;
      lastPage.value = response.meta?.lastPage ?? 1;
    } catch (e) {
      Helper().AlertSnackBar();
    } finally {
      isLoading(false);
      isLoadMore(false);
    }
  }

  Map<String, dynamic> change_status(status) {
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

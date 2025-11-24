import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/notification_repositoriy.dart';

class NotificationController extends GetxController {
  final NotificationRepositoriy repository;
  NotificationController({required this.repository});

  var isLoading = false.obs;
  var list_data = <NotificationModel>[].obs;
  var page_index = 0.obs;
  var isLoadMore = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var perPage = 10.obs;
  final scrollController = ScrollController();
  void onInit() {
    super.onInit();
    final context = Get.context!;
    perPage.value = Helper().calculatePerPage(context);
    getData();
    readAll();
    scrollController.addListener(() => onScroll());
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

      if (loadMore) {
        isLoadMore.value = true;
      } else {
        isLoading.value = true;
      }

      int _currentPage;
      _currentPage = loadMore ? currentPage.value + 1 : 1;
      final response = await repository.getData(
        page: _currentPage,
        perPage: perPage.value,
      );
      if (loadMore) {
        list_data.addAll(response.data);
      } else {
        list_data.assignAll(response.data);
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

  Future<void> readAll() async {
    try {
      await repository.readAll();
      // for (var i = 0; i < list_data.length; i++) {
      //   list_data[i] = list_data[i].copyWith(is_read: true);
      // }
    } catch (e) {
      Helper().AlertSnackBar();
    }
  }
}

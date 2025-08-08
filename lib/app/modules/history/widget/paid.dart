import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/core/widgets/not_found.dart';
import 'package:customer_billing/app/modules/history/history_controller.dart';
import 'package:customer_billing/app/modules/history/widget/list_data.dart';
import 'package:customer_billing/app/modules/history/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPaidPage extends StatelessWidget {
  final HistoryController controller;
  const ListPaidPage({required this.controller});
  @override
  Widget build(BuildContext context) {
    //function
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getData('paid');
    });

    return Obx(() {
      if (controller.isLoading.value) {
        return SkeletonListInvoice();
      }
      if (controller.invoice_data.isEmpty) {
        return NotFoundPage();
      }
      return RefreshIndicator(
          color: mainColor,
          onRefresh: () {
            Future.microtask(() => controller.getData('paid'));
            return Future.value(true);
          },
          child: Container(
            child: ListDataInovicePage(
                data: controller.invoice_data, controller: controller),
          ));
    });
  }
}

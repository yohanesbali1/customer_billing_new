import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/core/widgets/not_found.dart';
import 'package:customer_billing/app/modules/history/history_controller.dart';
import 'package:customer_billing/app/modules/history/widget/list_data.dart';
import 'package:customer_billing/app/modules/history/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListBillPage extends StatelessWidget {
  final HistoryController controller;
  const ListBillPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SkeletonListInvoice();
      }

      return RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await controller.getData('not_paid');
        },
        child: controller.invoice_not_paid_data.isEmpty
            ? ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: NotFoundPage(),
                  ),
                ],
              )
            : ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ListDataInovicePage(
                    data: controller.invoice_not_paid_data,
                    controller: controller,
                  ),
                ],
              ),
      );
    });
  }
}

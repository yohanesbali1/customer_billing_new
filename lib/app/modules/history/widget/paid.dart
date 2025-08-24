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
    return Obx(() {
      if (controller.isLoading.value) {
        return SkeletonListInvoice();
      }

      return RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await controller.getData('paid');
        },
        child: controller.invoice_paid_data.isEmpty
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
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListDataInovicePage(
                      data: controller.invoice_paid_data,
                      controller: controller,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}

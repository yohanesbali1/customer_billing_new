import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:vigo_customer_billing/app/modules/invoice/views/list_data.dart';
import 'package:vigo_customer_billing/app/modules/invoice/views/invoice_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListInvoicePage extends StatelessWidget {
  final InvoiceController controller;
  final String type; // 'paid' atau 'not_paid'

  ListInvoicePage({required this.controller, required this.type, super.key}) {
    controller.type.value = type;
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = type == 'paid';
    return Obx(() {
      final invoices = isPaid
          ? controller.invoice_paid_data
          : controller.invoice_not_paid_data;

      if (controller.isLoading.value && invoices.isEmpty) {
        return SkeletonListInvoice();
      }

      return RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await controller.getData(type);
        },
        child: invoices.isEmpty
            ? ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: NotFoundPage(),
                  ),
                ],
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !controller.isLoadMore.value) {
                    controller.getData(type, loadMore: true);
                  }
                  return false;
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        invoices.length + (controller.isLoadMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < invoices.length) {
                        return ListDataInovicePage(
                          data: invoices[index],
                          controller: controller,
                        );
                      } else {
                        // 🎨 STYLE LOADINGNYA DI SINI
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              // indikator bulat dengan warna utama
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation(mainColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
      );
    });
  }
}

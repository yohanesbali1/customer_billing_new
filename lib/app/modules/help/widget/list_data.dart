import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/help/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/item_help.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDataReportPage extends StatelessWidget {
  final HelpController controller;
  const ListDataReportPage({required this.controller});

  Widget build(BuildContext context) {
    return Obx(() {
      final data_report = controller.report_data;
      if (controller.isLoading.value && !controller.isLoadMore.value) {
        return SkeletonListReport();
      }
      return RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await controller.getData();
        },
        child: data_report.isEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: NotFoundPage(),
                ),
              )
            : ListView.builder(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    data_report.length + (controller.isLoadMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < data_report.length) {
                    return ItemHelp(
                      data: data_report[index],
                      controller: controller,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
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
      );
    });
  }
}

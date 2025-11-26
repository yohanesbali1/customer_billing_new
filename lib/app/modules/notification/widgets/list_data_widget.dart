import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/notification/controllers/notification_controller.dart';
import 'package:vigo_customer_billing/app/modules/notification/widgets/item_data_widget.dart';
import 'package:vigo_customer_billing/app/modules/notification/widgets/skeleton_widget.dart';

class ListDataNotificationPage extends GetView<NotificationController> {
  const ListDataNotificationPage({super.key});

  Widget build(BuildContext context) {
    return Obx(() {
      final data_report = controller.list_data;
      if (controller.isLoading.value && !controller.isLoadMore.value) {
        return SkeletonListNotification();
      }
      return RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await controller.getData();
          await controller.readAll();
        },
        child: data_report.isEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: NotFoundPage(),
                ),
              )
            : ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:
                      data_report.length +
                      (controller.isLoadMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < data_report.length) {
                      return ItemDataNotification(data: data_report[index]);
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
              ),
      );
    });
  }
}

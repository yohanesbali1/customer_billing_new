import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/history/history_controller.dart';
import 'package:vigo_customer_billing/app/modules/history/widget/list_data.dart';
import 'package:vigo_customer_billing/app/modules/history/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPaidPage extends StatefulWidget {
  final HistoryController controller;
  const ListPaidPage({required this.controller});

  @override
  State<ListPaidPage> createState() => _ListPaidPageState();
}

class _ListPaidPageState extends State<ListPaidPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final controller = widget.controller;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !controller.isLoadMore.value &&
        controller.currentPagePaid.value < controller.lastPagePaid.value) {
      controller.getData('paid', loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Obx(() {
      if (controller.isLoading.value && controller.invoice_paid_data.isEmpty) {
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
            : ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    controller.invoice_paid_data.length +
                    (controller.isLoadMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.invoice_paid_data.length) {
                    return ListDataInovicePage(
                      data: [
                        controller.invoice_paid_data[index],
                      ], // bungkus jadi list
                      controller: controller,
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
      );
    });
  }
}

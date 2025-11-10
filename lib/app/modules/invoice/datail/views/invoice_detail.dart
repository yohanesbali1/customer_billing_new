import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/controllers/invoice_detail_controller.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/widget/item_data.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailPage extends GetView<InvoiceDetailController> {
  const InvoiceDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Custom back icon
          onPressed: () {
            Get.back(); // Go back to the previous screen
          },
        ),
      ),
      body: Obx(() {
        final data = controller.invoiceData.value;
        final id = controller.id.value;
        if (controller.isLoading.value) {
          return SkeletonInvoiceDetail();
        }
        return RefreshIndicator(
          color: mainColor,
          onRefresh: () async {
            await controller.getData(id);
          },
          child: data == null
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
              : Container(
                  child: ItemDataInvoice(
                    data: data as InvoiceModel,
                    controller: controller,
                  ),
                ),
        );
      }),
    );
  }
}

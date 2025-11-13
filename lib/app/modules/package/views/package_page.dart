import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/package/controlllers/package_controller.dart';
import 'package:vigo_customer_billing/app/modules/package/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PackagePage extends GetView<PackageController> {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        final data = controller.applicationControllers.accountbillData.value;
        if (controller.isLoading.value) {
          return SkeletonAccountBill();
        }
        return RefreshIndicator(
          color: mainColor,
          onRefresh: () async {
            await controller.applicationControllers.getData();
          },
          child: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: data == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: NotFoundPage(),
                    )
                  : buildInvoiceItem(data as AccountBillModel, context),
            ),
          ),
        );
      }),
    );
  }

  Widget buildInvoiceItem(AccountBillModel data, context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Langganan',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  'Informasi langganan layanan anda',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: data.status == 'active' ? greenColor : redColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    data.status == 'active'
                        ? 'Langganan Aktif'
                        : 'Langganan Tidak Aktif',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID pelanggan',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            data.customer.code,
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jatuh Tempo',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${DateFormat("d MMMM yyyy").format(data.endDate)}",
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // const SizedBox(height: 20),
                Text(
                  'Rincian Langganan',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (context, index) {
                          final item = data.orders[index];
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: borderboxColor, // Set the border color
                                width: 0.5, // Set the border width
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.productName}',
                                  style: GoogleFonts.montserrat(
                                    color: textPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

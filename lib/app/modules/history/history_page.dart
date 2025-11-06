import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/history/widget/list_invoice.dart';
import 'package:vigo_customer_billing/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_controller.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history_c = Get.find<HistoryController>();
    final home_c = Get.find<HomeController>();
    history_c.onInit();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Riwayat',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Custom back icon
          onPressed: () {
            home_c.change_page(0); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          history_c.change_page(0);
                        },
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: history_c.page_index.value == 0
                                      ? mainColor
                                      : Colors.grey.shade300,
                                  width: history_c.page_index.value == 0
                                      ? 2.0
                                      : 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'Tagihan',
                              style: GoogleFonts.montserrat(
                                color: history_c.page_index.value == 0
                                    ? mainColor
                                    : textPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          history_c.change_page(1);
                        },
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: history_c.page_index.value == 1
                                      ? mainColor
                                      : Colors.grey.shade300,
                                  width: history_c.page_index.value == 1
                                      ? 2.0
                                      : 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'Lunas',
                              style: GoogleFonts.montserrat(
                                color: history_c.page_index.value == 1
                                    ? mainColor
                                    : textPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: history_c.pagecontroller,
                children: <Widget>[
                  ListInvoicePage(controller: history_c, type: 'not_paid'),
                  ListInvoicePage(controller: history_c, type: 'paid'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

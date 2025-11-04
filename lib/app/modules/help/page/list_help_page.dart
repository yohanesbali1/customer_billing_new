import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/list_data.dart';
import 'package:vigo_customer_billing/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(context) {
    final controller = Get.find<HelpController>();
    final home_c = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Bantuan',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Custom back icon
          onPressed: () {
            // Define the action for the back button (e.g., navigate to the previous screen)
            home_c.change_page(0); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: ListDataReportPage(controller: controller)),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/help/add');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: mainColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

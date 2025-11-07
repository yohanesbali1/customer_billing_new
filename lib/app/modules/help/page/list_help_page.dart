import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/list_data.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            home_c.change_page(0);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.toNamed('/help/add');
        },
      ),
      body: ListDataReportPage(controller: controller),
    );
  }
}

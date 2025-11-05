import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/help_controller.dart';

class ItemHelp extends StatelessWidget {
  final ReportModel data;
  final HelpController controller;
  const ItemHelp({required this.data, required this.controller});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/help/detail/${data.id}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        margin: EdgeInsets.only(
          top: 10,
          left: defaultMargin,
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.change_status(
                      data.status.status,
                    )['color'],
                  ),
                  child: Icon(
                    controller.change_status(data.status.status)['icon'],
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  data.status.description,
                  style: GoogleFonts.montserrat(
                    color: controller.change_status(
                      data.status.status,
                    )['color'],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("d MMMM yyyy").format(data.createdAt),
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data.typeTopic.type,
                    style: GoogleFonts.montserrat(
                      color: textSecondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Text(
                      'Lihat Detail',
                      style: GoogleFonts.montserrat(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      '>',
                      style: GoogleFonts.montserrat(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

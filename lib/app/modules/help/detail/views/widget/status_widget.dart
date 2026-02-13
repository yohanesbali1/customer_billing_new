import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/controlllers/help_detail_controller.dart';

class StatusWidget extends GetView<HelpDetailController> {
  final HelpModel data;
  const StatusWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // prevent inner scroll conflict
      padding: EdgeInsets.zero,
      itemCount: data != null ? data.status.length : 0,
      itemBuilder: (BuildContext context, int index) => Container(
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: controller.statusIcon(
                  data.status[index].status,
                )['color'],
                shape: BoxShape.circle,
              ),
              child: Icon(
                controller.statusIcon(data.status[index].status)['icon'],
                color: Colors.white,
                size: 16,
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.status[index].label,
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  DateFormat(
                    "d MMMM yyyy",
                  ).format(data.status[index].createdAt),
                  style: GoogleFonts.montserrat(
                    color: textSecondaryColor,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    );
  }
}

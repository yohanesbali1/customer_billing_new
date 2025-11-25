import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/notification/controllers/notification_controller.dart';

class ItemDataNotification extends GetView<NotificationController> {
  final NotificationModel data;
  const ItemDataNotification({required this.data});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.link != null) {
          Get.toNamed(data.link!);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        margin: EdgeInsets.only(
          top: 10,
          left: defaultMargin,
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: data.is_read ? Colors.white : mainColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              data.type,
              style: GoogleFonts.montserrat(
                color: data.is_read ? textSecondaryColor : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.title,
              style: GoogleFonts.montserrat(
                color: data.is_read ? textPrimaryColor : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              data.message,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                color: data.is_read ? textPrimaryColor : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 15),
            Text(
              DateFormat("d MMMM yyyy").format(data.createdAt),
              style: GoogleFonts.montserrat(
                color: data.is_read ? textSecondaryColor : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),

            // SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       DateFormat("d MMMM yyyy").format(data.createdAt),
            //       style: GoogleFonts.montserrat(
            //         color: textPrimaryColor,
            //         fontSize: 15,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Text(
            //         data.typeTopic.type,
            //         style: GoogleFonts.montserrat(
            //           color: textSecondaryColor,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     Row(
            //       children: [
            //         Text(
            //           'Lihat Detail',
            //           style: GoogleFonts.montserrat(
            //             color: mainColor,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             fontStyle: FontStyle.italic,
            //           ),
            //         ),
            //         Text(
            //           '>',
            //           style: GoogleFonts.montserrat(
            //             color: mainColor,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             fontStyle: FontStyle.italic,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
